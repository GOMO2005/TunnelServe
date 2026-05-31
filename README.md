# TunnelServe

**Local Files, Global Access**

TunnelServe is a lightweight cross-platform CLI tool that allows you to instantly share local files and directories over the internet using Cloudflare Tunnels.

No port forwarding. No router configuration. No complex setup.

TunnelServe automatically:

- Finds a free local port
- Starts a local HTTP server
- Creates a Cloudflare Tunnel
- Generates a public URL
- Lets you manage multiple active shares

Supports both **Linux** and **Windows**.

---

## Features

- Automatic dependency checking
- Automatic free-port detection
- Cloudflare Tunnel integration
- Instant file and folder sharing
- Multiple active server support
- Start, stop, and restart servers
- Interactive command-line interface
- Automatic cleanup on exit
- Lightweight and fast
- Cross-platform support

---

## Why TunnelServe?

Sharing local files often requires:

- Port forwarding
- Router access
- Dynamic DNS services
- Complex networking knowledge

TunnelServe removes all of that.

Simply select a file or folder, and TunnelServe generates a public URL that can be accessed from anywhere.

---

## How It Works

```text
Internet User
      │
      ▼
Cloudflare Tunnel
      │
      ▼
Local HTTP Server
      │
      ▼
Your Files
```

Your files remain on your computer.

Cloudflare Tunnel securely forwards requests from the public URL to your local machine.

---

## Supported Platforms

### Linux

- Ubuntu
- Debian
- Kali Linux
- Arch Linux
- Fedora
- Most Bash-based distributions

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
- Command Prompt (CMD) or PowerShell
- curl (built-in)

---

## Quick Start

### Linux

Clone the repository:

```bash
git clone https://github.com/GOMO2005/TunnelServe.git
cd TunnelServe
```

Make the script executable:

```bash
chmod +x tunnelserve.sh
```

Run TunnelServe:

```bash
./tunnelserve.sh
```

---

### Windows

Clone the repository:

```bat
git clone https://github.com/GOMO2005/TunnelServe.git
cd TunnelServe
```

Run:

```bat
tunnelserve.bat
```

---

## Installing Cloudflared

### Linux

```bash
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64

sudo mv cloudflared-linux-amd64 /usr/local/bin/cloudflared

sudo chmod +x /usr/local/bin/cloudflared
```

Verify installation:

```bash
cloudflared --version
```

---

### Windows

Download Cloudflared from:

https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/downloads/

Place `cloudflared.exe` in the same directory as `tunnelserve.bat` or add it to your system PATH.

Verify installation:

```bat
cloudflared --version
```

---

## Usage

### Linux

```bash
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

1) Start Server (Auto Port)
2) List Servers
3) Stop Server
4) Stop All Servers
5) Restart Server
6) Exit
```

---

## Sharing a File or Folder

1. Launch TunnelServe
2. Select **Start Server**
3. Enter the path to a file or folder
4. TunnelServe finds an available port
5. A local HTTP server starts automatically
6. A Cloudflare Tunnel is created
7. A public URL is generated
8. Share the URL with anyone

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

## Server Management

TunnelServe supports multiple active servers.

### Available Actions

| Action | Description |
|----------|----------|
| Start Server | Start a new share |
| List Servers | Show active servers |
| Stop Server | Stop a specific server |
| Stop All | Stop all active servers |
| Restart Server | Restart a selected server |
| Exit | Close TunnelServe and clean up |

---

## Security

### Important

Any person with the generated URL can access the shared files.

Before sharing:

- Do not expose sensitive files
- Share URLs only with trusted users
- Stop servers when no longer needed
- Remember that public URLs are accessible from anywhere

### Notes

- TunnelServe does not upload your files to Cloudflare.
- Files remain on your machine.
- Cloudflare Tunnel only forwards requests.
- TunnelServe does not currently provide password protection or authentication.

---

## Example Use Cases

- Share project builds
- Transfer files between devices
- Share logs with teammates
- Temporary file hosting
- Remote access to local resources
- Development and testing

---

## Project Goals

TunnelServe was built to:

- Eliminate manual port forwarding
- Simplify local file sharing
- Provide an easy CLI experience
- Support multiple simultaneous tunnels
- Work consistently on Linux and Windows

---

## Future Plans

- Password-protected shares
- Expiring links
- Custom domains
- Download statistics
- Configuration files
- Docker support
- macOS support

---

## Contributing

Contributions, bug reports, and feature requests are welcome.

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Open a pull request

---

## License

Licensed under the MIT License.

See the [LICENSE](LICENSE) file for details.

---

## Author

**GOMO2005**

GitHub: https://github.com/GOMO2005

---

# TunnelServe

**Share local files instantly with secure Cloudflare Tunnels.**
