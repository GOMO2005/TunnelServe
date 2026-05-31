# TunnelServe

**Local Files, Global Access.**

TunnelServe is a lightweight CLI tool that instantly shares local files and directories using Cloudflare Tunnels. It automatically detects an available port, starts a local HTTP server, creates a secure tunnel, and generates a public URL for sharing.

Currently supports **Linux** and **Windows (WSL)**.

---

## Features

- Automatic dependency checking
- Automatic free-port detection
- Cloudflare Tunnel integration
- Instant file and directory sharing
- Multi-server support
- Start, stop, and restart servers
- Interactive CLI menu
- Automatic cleanup on exit
- Lightweight and fast

---

## Supported Platforms

### Linux

- Ubuntu
- Debian
- Kali Linux
- Any Bash-based distribution

### Windows

- Windows 10 / 11 (WSL)

---

## Requirements

- Bash
- Python 3
- pip3
- curl
- wget
- lsof
- cloudflared

---

## Installation

No installation required.

Clone the repository and run the script:

```bash
git clone https://github.com/GOMO2005/TunnelServe.git
cd TunnelServe
chmod +x tunnelserve.sh
./tunnelserve.sh
```

---

## Demo

### GIF Preview

![TunnelServe Demo](assets/demo.gif)

### Video

🎬 Watch the full demo:

[▶ Watch Demo](https://github.com/GOMO2005/TunnelServe/blob/main/assest/demo.mp4)

---

## Interface

```text
=====================================
          TUNNELSERVE
=====================================

1) Start Server (Auto Port)
2) List Servers
3) Stop Server
4) Stop All
5) Restart Server
6) Exit
```

---

## How It Works

1. Run TunnelServe
2. Select **Start Server**
3. Enter a file or folder path
4. TunnelServe finds a free port
5. A local HTTP server starts
6. A Cloudflare Tunnel is created
7. A public URL is generated
8. Share the URL instantly

---

## Example Output

```text
✔ Server Started

ID:   123456789
PORT: 8000

URL:
https://example.trycloudflare.com

FILE:
https://example.trycloudflare.com/sample.zip
```

---

## Security Notice

⚠️ Anyone with the generated URL can access the shared files.

- Do not share sensitive data.
- Stop servers when sharing is no longer needed.
- TunnelServe does not currently provide authentication or password protection.

---

## License

This project is licensed under the MIT License.
