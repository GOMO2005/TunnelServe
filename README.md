# TunnelServe

**Local Files, Global Access.**

TunnelServe is an interactive command-line utility that instantly shares local files and directories through secure Cloudflare Tunnels. It automatically finds an available port, launches a local HTTP server, creates a public Cloudflare tunnel, and provides a shareable URL.

## Features

* Automatic dependency checking
* Automatic free-port detection
* Cloudflare Tunnel integration
* Share individual files or entire directories
* Multiple server management
* Start, stop, and restart active tunnels
* Interactive terminal interface
* Automatic cleanup on exit
* Lightweight and easy to use
* Designed for Debian, Ubuntu, and Kali Linux

## Requirements

* Bash
* Python 3
* pip3
* curl
* wget
* lsof
* cloudflared

## Supported Systems

* Ubuntu
* Debian
* Kali Linux

## Usage

Run the script:

```bash
chmod +x tunnelserve.sh
./tunnelserve.sh
```

## Main Menu

```text
=====================================
   CLOUDFLARE AUTO-PORT CLI
=====================================

1) Start server (auto port)
2) List servers
3) Stop server
4) Stop all
5) Restart server
6) Exit
```

## How It Works

1. Select "Start Server".
2. Enter a file or directory path.
3. TunnelServe automatically finds an available port.
4. A local HTTP server is started.
5. Cloudflare Tunnel is created.
6. A public URL is generated.
7. Share the URL with anyone.

Example:

```text
✔ Server Started

ID:   123456789
PORT: 8000
URL:  https://example.trycloudflare.com
FILE: https://example.trycloudflare.com/sample.zip
```

## Project Goals

TunnelServe aims to provide a simple way to:

* Share files without configuring routers
* Expose local directories securely
* Quickly create temporary public links
* Manage multiple active tunnels from one interface

## Security Notice

Anyone with the generated Cloudflare Tunnel URL can access the exposed content. Share links carefully and stop servers when they are no longer needed.

## Roadmap

* Custom domain support
* QR code generation
* Download statistics
* Authentication options
* Persistent tunnel profiles
* Cross-platform support

## Contributing

Contributions, feature requests, and bug reports are welcome.

## License

MIT License

## Disclaimer

This project is intended for educational, development, and legitimate file-sharing purposes only. Users are responsible for complying with all applicable laws, regulations, and Cloudflare terms of service.
