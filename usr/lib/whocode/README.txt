whocode for Linux â€” 2099.12.31.1 (no-reset)

Portable:
    bash ./whocode

Install for the current user:
    bash ./install.sh
    then launch "whocode" from the app menu, or ~/.local/share/whocode/whocode

Requirements: x86-64 Linux, glibc 2.31+, GTK3, NSS, ALSA, GBM.
  Debian/Ubuntu: sudo apt install libgtk-3-0 libnss3 libasound2t64 libgbm1
  Fedora:        sudo dnf install gtk3 nss alsa-lib mesa-libgbm
  Arch:          sudo pacman -S gtk3 nss alsa-lib mesa

First launch asks for a license key. The activation is bound to this machine
(Linux HWID comes from /etc/machine-id). Cache: ~/.local/share/opencode/license.json
App data: ~/.config/ai.opencode.desktop.dev

This is the no-reset build:
  - reset pill hidden and no reset launcher installed
  - version pinned at 2099.12.31.1, so the 2026 update feed is never offered
  - announcement poller, auto-open after activation and the update watcher are
    present, same as the stable Windows build

Sandbox: the runtime starts with --no-sandbox because a user-owned install
cannot ship a setuid chrome-sandbox. To enable it:
    sudo chown root:root runtime/chrome-sandbox
    sudo chmod 4755 runtime/chrome-sandbox
    WHOCODE_SANDBOX=1 ./whocode

Sidecar: the backend is the upstream opencode CLI 2.2.7 for linux-x64.
The fork-only rotation handlers are not part of a no-reset build, so the reset
path is absent by design. Model access is whatever you configure in the app.