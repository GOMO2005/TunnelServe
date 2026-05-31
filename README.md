
# TunnelServe

**Local Files, Global Access**

TunnelServe is a cross-platform CLI tool that instantly shares local files and directories using secure Cloudflare Tunnels. It automatically detects an available port, starts a local HTTP server, creates a tunnel, and generates a public URL for easy sharing.

Supports both **Linux (Bash)** and  **Windows (Batch)** .

---

## Features

* Automatic dependency checking
* Automatic free-port detection
* Cloudflare Tunnel integration
* Instant file and directory sharing
* Multiple server support
* Start, stop, and restart servers
* Interactive CLI menu
* Automatic cleanup on exit
* Lightweight and fast
* Cross-platform support (Linux and Windows)

---

## Supported Platforms

### Linux

* Ubuntu
* Debian
* Kali Linux
* Any Bash-based distribution

### Windows

* Windows 10
* Windows 11

---

## Requirements

### Linux

* Bash
* Python 3
* pip3
* curl
* wget
* lsof
* cloudflared

### Windows

* Python 3
* cloudflared.exe
* Command Prompt (CMD) or PowerShell
* curl (built-in on modern Windows versions)

---

## Installation

No installation is required.

Simply download the appropriate script and run it.

---

## Usage

### Linux

<pre class="overflow-visible! px-0!" data-start="1304" data-end="1356"><div class="relative w-full mt-4 mb-1"><div class=""><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="h-full w-full border-radius-3xl bg-token-bg-elevated-secondary corner-superellipse/1.1 overflow-clip rounded-3xl lxnfua_clipPathFallback"><div class="pointer-events-none absolute inset-x-4 top-12 bottom-4"><div class="pointer-events-none sticky z-40 shrink-0 z-1!"><div class="sticky bg-token-border-light"></div></div></div><div class="relative"><div class=""><div class="relative z-0 flex max-w-full"><div id="code-block-viewer" dir="ltr" class="q9tKkq_viewer cm-editor z-10 light:cm-light dark:cm-light flex h-full w-full flex-col items-stretch ͼd ͼr"><div class="cm-scroller"><pre class="cm-content q9tKkq_readonly m-0"><code><span class="ͼl">chmod</span><span></span><span class="ͼg">+</span><span>x tunnelserve.sh</span><br/><span>./tunnelserve.sh</span></code></pre></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></pre>

### Windows

<pre class="overflow-visible! px-0!" data-start="1371" data-end="1397"><div class="relative w-full mt-4 mb-1"><div class=""><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="h-full w-full border-radius-3xl bg-token-bg-elevated-secondary corner-superellipse/1.1 overflow-clip rounded-3xl lxnfua_clipPathFallback"><div class="pointer-events-none absolute inset-x-4 top-12 bottom-4"><div class="pointer-events-none sticky z-40 shrink-0 z-1!"><div class="sticky bg-token-border-light"></div></div></div><div class="relative"><div class=""><div class="relative z-0 flex max-w-full"><div id="code-block-viewer" dir="ltr" class="q9tKkq_viewer cm-editor z-10 light:cm-light dark:cm-light flex h-full w-full flex-col items-stretch ͼd ͼr"><div class="cm-scroller"><pre class="cm-content q9tKkq_readonly m-0"><code><span>tunnelserve.bat</span></code></pre></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></pre>

---

## Interface

<pre class="overflow-visible! px-0!" data-start="1418" data-end="1635"><div class="relative w-full mt-4 mb-1"><div class=""><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="h-full w-full border-radius-3xl bg-token-bg-elevated-secondary corner-superellipse/1.1 overflow-clip rounded-3xl lxnfua_clipPathFallback"><div class="pointer-events-none absolute end-1.5 top-1 z-2 md:end-2 md:top-1"></div><div class="relative"><div class="pe-11 pt-3"><div class="relative z-0 flex max-w-full"><div id="code-block-viewer" dir="ltr" class="q9tKkq_viewer cm-editor z-10 light:cm-light dark:cm-light flex h-full w-full flex-col items-stretch ͼd ͼr"><div class="cm-scroller"><pre class="cm-content q9tKkq_readonly m-0"><code><span>=====================================</span><br/><span>            TUNNELSERVE</span><br/><span>=====================================</span><br/><br/><span>1) Start Server (Auto Port)</span><br/><span>2) List Servers</span><br/><span>3) Stop Server</span><br/><span>4) Stop All Servers</span><br/><span>5) Restart Server</span><br/><span>6) Exit</span></code></pre></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></pre>

---

## How It Works

1. Run TunnelServe
2. Select **Start Server**
3. Enter a file or folder path
4. TunnelServe automatically finds a free port
5. A local HTTP server is started
6. A Cloudflare Tunnel is created
7. A public URL is generated
8. Share the URL instantly

---

## Example Output

<pre class="overflow-visible! px-0!" data-start="1932" data-end="2079"><div class="relative w-full mt-4 mb-1"><div class=""><div class="relative"><div class="h-full min-h-0 min-w-0"><div class="h-full min-h-0 min-w-0"><div class="border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl"><div class="h-full w-full border-radius-3xl bg-token-bg-elevated-secondary corner-superellipse/1.1 overflow-clip rounded-3xl lxnfua_clipPathFallback"><div class="pointer-events-none absolute end-1.5 top-1 z-2 md:end-2 md:top-1"></div><div class="relative"><div class="pe-11 pt-3"><div class="relative z-0 flex max-w-full"><div id="code-block-viewer" dir="ltr" class="q9tKkq_viewer cm-editor z-10 light:cm-light dark:cm-light flex h-full w-full flex-col items-stretch ͼd ͼr"><div class="cm-scroller"><pre class="cm-content q9tKkq_readonly m-0"><code><span>✔ Server Started</span><br/><br/><span>ID:   123456789</span><br/><span>PORT: 8000</span><br/><span>URL:  https://example.trycloudflare.com</span><br/><span>FILE: https://example.trycloudflare.com/sample.zip</span></code></pre></div></div></div></div></div></div></div></div></div><div class=""><div class=""></div></div></div></div></div></pre>

---

## Project Goals

TunnelServe is designed to:

* Eliminate manual port forwarding
* Share files instantly over the internet
* Provide simple CLI-based management
* Support multiple active tunnels
* Work seamlessly on Linux and Windows

---

## Security Notice

⚠️ Anyone with the generated URL can access the shared files.

When sharing is no longer needed, stop the server to disable access.

---

## License

MIT License
