# TunnelServe

**Local Files, Global Access.**

TunnelServe is a cross-platform CLI tool that instantly shares local files and directories using secure Cloudflare Tunnels. It automatically detects a free port, starts a local HTTP server, creates a tunnel, and generates a public URL.

Supports both **Linux (Bash)** and **Windows (Batch)**.

---

## Features

- Automatic dependency checking
- Auto free-port detection
- Cloudflare Tunnel integration
- Share files or directories instantly
- Multi-server support
- Start, stop, and restart servers
- Interactive CLI menu
- Auto cleanup on exit
- Lightweight and fast
- Cross-platform (Linux + Windows)

---

## Supported Platforms

### Linux

- Ubuntu
- Debian
- Kali Linux
- Any Bash-based system

### Windows

- Windows 10
- Windows 11

---

## Requirements

### Linux

- Bash
- Python 3
- pip3
- curl
- wget
- lsof
- cloudflared

### Windows

- Python 3
- cloudflared.exe
- CMD or PowerShell
- curl (built-in)

---

## Installation

No installation required.

Just download and run the script.

---

## Usage

### Linux

```bash
chmod +x tunnelserve.sh
./tunnelserve.sh
```

### Windows

```bat
tunnelserve.bat
```

---

## Interface

```text
=====================================
          TUNNELSERVE
=====================================

1) Start server (auto port)
2) List servers
3) Stop server
4) Stop all
5) Restart server
6) Exit
```

---

## How It Works

1. Run TunnelServe
2. Select **Start Server**
3. Enter file or folder path
4. Tool finds a free port automatically
5. Starts local HTTP server
6. Creates Cloudflare Tunnel
7. Generates public URL
8. Share instantly

---

## Example Output

```text
✔ Server Started

ID:   123456789
PORT: 8000
URL:  https://example.trycloudflare.com
FILE: https://example.trycloudflare.com/sample.zip
```

---

## Project Goals

TunnelServe is built to:

- Eliminate manual port forwarding
- Share files instantly over the internet
- Provide simple CLI-based control
- Support multiple active tunnels
- Work on both Linux and Windows

---

## Security Notice

⚠️ Any user with the generated URL can access shared files.

Stop the server when sharing is no longer needed.

---

## Roadmap

- PowerShell-based Windows version upgrade
- QR code link generator
- Password-protected tunnels
- Download tracking
- Custom domain support
- Persistent tunnel profiles

---

## Contributing

Pull requests and issues are welcome.

---

## License

This project is licensed under the MIT License.
