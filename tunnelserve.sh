#!/bin/bash

# ==============================================================================
# Cloudflared Interactive CLI (Auto-Port & Self-Installer)
# Linux (Debian/Ubuntu/Kali)
# ==============================================================================

set -o pipefail

# ------------------------------------------------------------------------------
# Auto-Dependency Check & Installer
# ------------------------------------------------------------------------------
check_dependencies() {
    local missing_deps=()
    for cmd in python3 pip3 curl wget lsof cloudflared; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            # Special case check for pip3 which maps to python3-pip package
            if [ "$cmd" = "pip3" ]; then
                missing_deps+=("python3-pip")
            else
                missing_deps+=("$cmd")
            fi
        fi
    done

    if [ ${#missing_deps[@]} -ne 0 ]; then
        echo "[!] Missing dependencies detected: ${missing_deps[*]}"
        read -p "[?] Would you like to install them now? (y/N): " install_choice
        if [[ "$install_choice" =~ ^[Yy]$ ]]; then
            echo "[*] Updating package lists..."
            sudo apt update

            # Separate cloudflared for custom installation if it's in the list
            local apt_deps=()
            local install_cf=false
            for dep in "${missing_deps[@]}"; do
                if [ "$dep" = "cloudflared" ]; then
                    install_cf=true
                else
                    apt_deps+=("$dep")
                fi
            done

            if [ ${#apt_deps[@]} -ne 0 ]; then
                echo "[*] Installing system dependencies..."
                sudo apt install -y "${apt_deps[@]}"
            fi

            if [ "$install_cf" = true ]; then
                echo "[*] Fetching and installing Cloudflared..."
                ARCH=$(dpkg --print-architecture)
                case "$ARCH" in
                    amd64) CF_URL="https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb" ;;
                    arm64) CF_URL="https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64.deb" ;;
                    armhf) CF_URL="https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm.deb" ;;
                    *)
                        echo "[!] Unsupported architecture for automatic cloudflared installation: $ARCH"
                        exit 1
                        ;;
                esac
                wget -O /tmp/cloudflared.deb "$CF_URL"
                sudo dpkg -i /tmp/cloudflared.deb || sudo apt-get install -f -y
                rm -f /tmp/cloudflared.deb
            fi
            echo "[✔] Setup completed successfully!"
            sleep 2
        else
            echo "[!] Cannot proceed without dependencies. Exiting."
            exit 1
        fi
    fi
}

# Run dependency check first thing
check_dependencies

# ------------------------------------------------------------------------------
# Core Variables & Storage Maps
# ------------------------------------------------------------------------------
declare -A PORT_MAP DIR_MAP FILE_MAP HTTP_PID_MAP CF_PID_MAP URL_MAP

PORT_START=8000
PORT_END=9000

# ------------------------------------------------------------------------------
# Utilities
# ------------------------------------------------------------------------------
gen_id() {
    date +%s%N | cut -b10-18
}

pause() {
    read -p "Press ENTER to continue..."
}

is_port_free() {
    ! lsof -i :"$1" >/dev/null 2>&1
}

get_free_port() {
    for ((p=PORT_START; p<=PORT_END; p++)); do
        if is_port_free "$p"; then
            echo "$p"
            return
        fi
    done
    echo ""
}

cleanup_server() {
    local id="$1"

    kill "${HTTP_PID_MAP[$id]}" 2>/dev/null || true
    kill "${CF_PID_MAP[$id]}" 2>/dev/null || true

    unset PORT_MAP[$id]
    unset DIR_MAP[$id]
    unset FILE_MAP[$id]
    unset HTTP_PID_MAP[$id]
    unset CF_PID_MAP[$id]
    unset URL_MAP[$id]
}

stop_all() {
    for id in "${!PORT_MAP[@]}"; do
        cleanup_server "$id"
    done
}

trap "echo; stop_all; echo 'Exited safely.'; exit" INT TERM

# ------------------------------------------------------------------------------
# Start Server Engine
# ------------------------------------------------------------------------------
start_server() {
    read -p "Enter file/directory path: " TARGET

    if [ -z "$TARGET" ] || [ ! -e "$TARGET" ]; then
        echo "Invalid path."
        pause
        return
    fi

    PORT=$(get_free_port)

    if [ -z "$PORT" ]; then
        echo "No free ports available in range $PORT_START-$PORT_END"
        pause
        return
    fi

    ID=$(gen_id)
    LOG=$(mktemp)

    if [ -f "$TARGET" ]; then
        DIR=$(cd "$(dirname "$TARGET")" && pwd)
        FILE=$(basename "$TARGET")
    else
        DIR=$(cd "$TARGET" && pwd)
        FILE=""
    fi

    echo "Starting server on auto port $PORT..."

    (
        cd "$DIR" || exit
        python3 -m http.server "$PORT" >/dev/null 2>&1 &
        echo $! > /tmp/http_$ID.pid
    )

    HTTP_PID=$(cat /tmp/http_$ID.pid)
    rm -f /tmp/http_$ID.pid

    sleep 1

    cloudflared tunnel \
        --url "http://localhost:$PORT" \
        --no-autoupdate \
        > "$LOG" 2>&1 &

    CF_PID=$!

    # Wait for URL compilation
    URL=""
    for i in {1..30}; do
        URL=$(grep -Eo 'https://[-a-z0-9]+\.trycloudflare\.com' "$LOG" | head -n1)
        kill -0 "$CF_PID" 2>/dev/null || break
        [ -n "$URL" ] && break
        sleep 1
    done

    if [ -z "$URL" ]; then
        echo "Failed to create tunnel."
        kill "$HTTP_PID" "$CF_PID" 2>/dev/null
        pause
        return
    fi

    rm -f "$LOG"

    PORT_MAP[$ID]=$PORT
    DIR_MAP[$ID]=$DIR
    FILE_MAP[$ID]=$FILE
    HTTP_PID_MAP[$ID]=$HTTP_PID
    CF_PID_MAP[$ID]=$CF_PID
    URL_MAP[$ID]=$URL

    echo ""
    echo "✔ Server Started"
    echo "ID:   $ID"
    echo "PORT: $PORT"
    echo "URL:  $URL"
    [ -n "$FILE" ] && echo "FILE: $URL/$FILE"

    pause
}

# ------------------------------------------------------------------------------
# Manage Running Servers
# ------------------------------------------------------------------------------
list_servers() {
    echo ""
    echo "========== ACTIVE SERVERS =========="

    if [ ${#PORT_MAP[@]} -eq 0 ]; then
        echo "No active servers."
        pause
        return
    fi

    for id in "${!PORT_MAP[@]}"; do
        kill -0 "${HTTP_PID_MAP[$id]}" 2>/dev/null || cleanup_server "$id"
        kill -0 "${CF_PID_MAP[$id]}" 2>/dev/null || cleanup_server "$id"

        echo ""
        echo "ID:   $id"
        echo "PORT: ${PORT_MAP[$id]}"
        echo "DIR:  ${DIR_MAP[$id]}"
        [ -n "${FILE_MAP[$id]}" ] && echo "FILE: ${FILE_MAP[$id]}"
        echo "URL:  ${URL_MAP[$id]}"
        echo "-----------------------------------"
    done

    pause
}

stop_server() {
    read -p "Enter server ID: " ID

    if [ -z "${PORT_MAP[$ID]}" ]; then
        echo "Server not found."
        pause
        return
    fi

    cleanup_server "$ID"
    echo "✔ Server stopped"
    pause
}

restart_server() {
    read -p "Enter server ID: " ID
    read -p "Enter new path: " NEW_PATH

    if [ -z "${PORT_MAP[$ID]}" ] || [ ! -e "$NEW_PATH" ]; then
        echo "Invalid input."
        pause
        return
    fi

    cleanup_server "$ID"
    echo "Restarting..."
    sleep 1

    # Route directly through core start logic using variables instead of duplicate block
    TARGET="$NEW_PATH"
    PORT=$(get_free_port)

    if [ -z "$PORT" ]; then
        echo "No free ports available."
        pause
        return
    fi

    ID=$(gen_id)
    LOG=$(mktemp)

    if [ -f "$TARGET" ]; then
        DIR=$(cd "$(dirname "$TARGET")" && pwd)
        FILE=$(basename "$TARGET")
    else
        DIR=$(cd "$TARGET" && pwd)
        FILE=""
    fi

    (
        cd "$DIR" || exit
        python3 -m http.server "$PORT" >/dev/null 2>&1 &
        echo $! > /tmp/http_$ID.pid
    )
    HTTP_PID=$(cat /tmp/http_$ID.pid)
    rm -f /tmp/http_$ID.pid

    sleep 1

    cloudflared tunnel --url "http://localhost:$PORT" --no-autoupdate > "$LOG" 2>&1 &
    CF_PID=$!

    URL=""
    for i in {1..30}; do
        URL=$(grep -Eo 'https://[-a-z0-9]+\.trycloudflare\.com' "$LOG" | head -n1)
        kill -0 "$CF_PID" 2>/dev/null || break
        [ -n "$URL" ] && break
        sleep 1
    done

    rm -f "$LOG"

    PORT_MAP[$ID]=$PORT
    DIR_MAP[$ID]=$DIR
    FILE_MAP[$ID]=$FILE
    HTTP_PID_MAP[$ID]=$HTTP_PID
    CF_PID_MAP[$ID]=$CF_PID
    URL_MAP[$ID]=$URL

    echo "✔ Restarted: $URL"
    pause
}

# ------------------------------------------------------------------------------
# Interactive UI Loop
# ------------------------------------------------------------------------------
while true; do
    clear
    echo "====================================="
    echo "   CLOUDFLARE AUTO-PORT CLI"
    echo "====================================="
    echo "Port range: $PORT_START - $PORT_END"
    echo "-------------------------------------"
    echo "1) Start server (auto port)"
    echo "2) List servers"
    echo "3) Stop server"
    echo "4) Stop all"
    echo "5) Restart server"
    echo "6) Exit"
    echo "-------------------------------------"

    read -p "Select option: " opt

    case "$opt" in
        1) start_server ;;
        2) list_servers ;;
        3) stop_server ;;
        4) stop_all; echo "All stopped"; pause ;;
        5) restart_server ;;
        6) stop_all; exit 0 ;;
        *) echo "Invalid option"; sleep 1 ;;
    esac
done
