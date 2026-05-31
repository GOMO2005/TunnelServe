TunnelServe

Local Files, Global Access

TunnelServe is a cross-platform CLI tool that instantly shares local files and directories using secure Cloudflare Tunnels. It automatically detects an available port, starts a local HTTP server, creates a tunnel, and generates a public URL for easy sharing.

Supports both Linux (Bash) and Windows (Batch).

Features
Automatic dependency checking
Automatic free-port detection
Cloudflare Tunnel integration
Instant file and directory sharing
Multiple server support
Start, stop, and restart servers
Interactive CLI menu
Automatic cleanup on exit
Lightweight and fast
Cross-platform support (Linux and Windows)
Supported Platforms
Linux
Ubuntu
Debian
Kali Linux
Any Bash-based distribution
Windows
Windows 10
Windows 11
Requirements
Linux
Bash
Python 3
pip3
curl
wget
lsof
cloudflared
Windows
Python 3
cloudflared.exe
Command Prompt (CMD) or PowerShell
curl (built-in on modern Windows versions)
Installation

No installation is required.

Simply download the appropriate script and run it.

Usage
Linux
chmod +x tunnelserve.sh
./tunnelserve.sh
Windows
tunnelserve.bat
Interface
=====================================
            TUNNELSERVE
=====================================

1) Start Server (Auto Port)
2) List Servers
3) Stop Server
4) Stop All Servers
5) Restart Server
6) Exit
How It Works
Run TunnelServe
Select Start Server
Enter a file or folder path
TunnelServe automatically finds a free port
A local HTTP server is started
A Cloudflare Tunnel is created
A public URL is generated
Share the URL instantly
Example Output
✔ Server Started

ID:   123456789
PORT: 8000
URL:  https://example.trycloudflare.com
FILE: https://example.trycloudflare.com/sample.zip
Project Goals

TunnelServe is designed to:

Eliminate manual port forwarding
Share files instantly over the internet
Provide simple CLI-based management
Support multiple active tunnels
Work seamlessly on Linux and Windows
Security Notice

⚠️ Anyone with the generated URL can access the shared files.

When sharing is no longer needed, stop the server to disable access.

License

MIT License
