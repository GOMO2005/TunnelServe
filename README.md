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
- Start, stop, restart servers
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

<pre class="overflow-visible! px-0!" data-start="1226" data-end="1252"><div class="relative w-full mt-4 mb-1"><div class=""><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="h-full w-full border-radius-3xl bg-token-bg-elevated-secondary corner-superellipse/1.1 overflow-clip rounded-3xl lxnfua_clipPathFallback"><div class="pointer-events-none absolute inset-x-4 top-12 bottom-4"><div class="pointer-events-none sticky z-40 shrink-0 z-1!"><div class="sticky bg-token-border-light"></div></div></div><div class="relative"><div class=""><div class="relative z-0 flex max-w-full"><div id="code-block-viewer" dir="ltr" class="q9tKkq_viewer cm-editor z-10 light:cm-light dark:cm-light flex h-full w-full flex-col items-stretch ͼd ͼr"><div class="cm-scroller"><pre class="cm-content q9tKkq_readonly m-0"><code><span>tunnelserve.bat</span></code></pre></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></pre>

---

## Interface

<pre class="overflow-visible! px-0!" data-start="1273" data-end="1476"><div class="relative w-full mt-4 mb-1"><div class=""><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="h-full w-full border-radius-3xl bg-token-bg-elevated-secondary corner-superellipse/1.1 overflow-clip rounded-3xl lxnfua_clipPathFallback"><div class="pointer-events-none absolute end-1.5 top-1 z-2 md:end-2 md:top-1"></div><div class="relative"><div class="pe-11 pt-3"><div class="relative z-0 flex max-w-full"><div id="code-block-viewer" dir="ltr" class="q9tKkq_viewer cm-editor z-10 light:cm-light dark:cm-light flex h-full w-full flex-col items-stretch ͼd ͼr"><div class="cm-scroller"><pre class="cm-content q9tKkq_readonly m-0"><code><span>=====================================</span><br/><span>          TUNNELSERVE</span><br/><span>=====================================</span><br/><br/><span>1) Start server (auto port)</span><br/><span>2) List servers</span><br/><span>3) Stop server</span><br/><span>4) Stop all</span><br/><span>5) Restart server</span><br/><span>6) Exit</span></code></pre></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></pre>

---

## How It Works

1. Run TunnelServe
2. Select "Start Server"
3. Enter file or folder path
4. Tool finds a free port automatically
5. Starts local HTTP server
6. Creates Cloudflare Tunnel
7. Generates public URL
8. Share instantly

---

## Example Output

<pre class="overflow-visible! px-0!" data-start="1738" data-end="1881"><div class="relative w-full mt-4 mb-1"><div class=""><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="h-full w-full border-radius-3xl bg-token-bg-elevated-secondary corner-superellipse/1.1 overflow-clip rounded-3xl lxnfua_clipPathFallback"><div class="pointer-events-none absolute end-1.5 top-1 z-2 md:end-2 md:top-1"></div><div class="relative"><div class="pe-11 pt-3"><div class="relative z-0 flex max-w-full"><div id="code-block-viewer" dir="ltr" class="q9tKkq_viewer cm-editor z-10 light:cm-light dark:cm-light flex h-full w-full flex-col items-stretch ͼd ͼr"><div class="cm-scroller"><pre class="cm-content q9tKkq_readonly m-0"><code><span>✔ Server Started</span><br/><br/><span>ID:   123456789</span><br/><span>PORT: 8000</span><br/><span>URL:  https://example.trycloudflare.com</span><br/><span>FILE: https://example.trycloudflare.com/sample.zip</span></code></pre></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></pre>

---

## Project Goals

TunnelServe is built to:

* Eliminate manual port forwarding
* Share files instantly over internet
* Provide simple CLI-based control
* Support multiple active tunnels
* Work on both Linux and Windows

---

## Security Notice

Any user with the generated URL can access shared files.

Stop the server when sharing is no longer needed.


## License

MIT License

---
