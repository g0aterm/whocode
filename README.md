# whocode

Linux desktop build of whocode (Electron + opencode CLI sidecar).  
Version pin: **2099.12.31.1** (no-reset build).

## Requirements

- x86-64 Linux, glibc 2.31+
- GTK3, NSS, ALSA, GBM

| Distro | Packages |
|--------|----------|
| Arch | `sudo pacman -S gtk3 nss alsa-lib mesa` |
| Debian/Ubuntu | `sudo apt install libgtk-3-0 libnss3 libasound2t64 libgbm1` |
| Fedora | `sudo dnf install gtk3 nss alsa-lib mesa-libgbm` |

## Quick start (portable)

From the repo root (AppImage-style layout):

```bash
chmod +x AppRun usr/lib/whocode/whocode
./AppRun
# or:
bash ./usr/lib/whocode/whocode
```

First launch asks for a **license key**. Activation is bound to this machine via `/etc/machine-id`.

| Path | Purpose |
|------|---------|
| `~/.local/share/opencode/license.json` | license cache |
| `~/.config/ai.opencode.desktop.dev` | app data |

## Install (current user)

```bash
bash ./usr/lib/whocode/install.sh
```

That copies the tree to `~/.local/share/whocode`, installs a desktop entry + icon, then you can launch **whocode** from the app menu or:

```bash
~/.local/share/whocode/whocode
```

Override install location:

```bash
WHOCODE_PREFIX=/path/you/want bash ./usr/lib/whocode/install.sh
```

Remove:

```bash
rm -rf ~/.local/share/whocode \
  ~/.local/share/applications/whocode.desktop \
  ~/.local/share/icons/hicolor/512x512/apps/whocode.png
```

## Runtime flags

| Env var | Effect |
|---------|--------|
| `WHOCODE_X11=1` | force X11 (handy on Wayland/NVIDIA) |
| `WHOCODE_DISABLE_GPU=1` | software rendering |
| `WHOCODE_SANDBOX=1` | use chrome sandbox (needs setuid helper first) |

Enable sandbox:

```bash
sudo chown root:root usr/lib/whocode/runtime/chrome-sandbox
sudo chmod 4755 usr/lib/whocode/runtime/chrome-sandbox
WHOCODE_SANDBOX=1 ./AppRun
```

Default launch uses `--no-sandbox` because a user-owned tree cannot ship a setuid sandbox.

## What’s in this repo

This checkout is the portable Linux tree (`AppRun`, `usr/lib/whocode/...`).

GitHub’s 100 MB file limit means these are **not** in git (see `.gitignore`):

- `usr/lib/whocode/runtime/electron` (~218 MB)
- `usr/lib/whocode/app/desktop-pkg/resources/opencode-cli` (~247 MB)

Put those binaries back in place (from a full package / Release asset) before running. Without them the launcher will fail.

`node_modules` under `desktop-pkg` is also omitted from git.

## Notes

- Sidecar: upstream **opencode CLI 2.2.7** (linux-x64).
- No-reset build: reset pill/launcher absent; version pinned so the 2026 update feed is not offered.
- Model access is whatever you configure inside the app.
