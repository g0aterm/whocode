#!/usr/bin/env bash
# Per-user install for whocode on Linux.
#
#   bash install.sh
#
# Installs under ~/.local/share/whocode, drops a .desktop entry, and copies
# the icon into the hicolor theme. Override the prefix with WHOCODE_PREFIX.
set -euo pipefail

src="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
prefix="${WHOCODE_PREFIX:-$HOME/.local/share/whocode}"
data="${XDG_DATA_HOME:-$HOME/.local/share}"

install -d "$prefix"
cp -a "$src/." "$prefix/"
chmod 755 "$prefix/whocode" \
          "$prefix/install.sh" \
          "$prefix/runtime/electron" \
          "$prefix/app/desktop-pkg/resources/opencode-cli"

install -d "$data/applications" "$data/icons/hicolor/512x512/apps"
install -m 644 "$src/whocode.png" "$data/icons/hicolor/512x512/apps/whocode.png"

cat > "$data/applications/whocode.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=whocode
Comment=whocode desktop
Exec=$prefix/whocode %U
Icon=whocode
Terminal=false
Categories=Development;
StartupWMClass=whocode-desktop
EOF
chmod 644 "$data/applications/whocode.desktop"

if command -v update-desktop-database >/dev/null 2>&1; then
  update-desktop-database "$data/applications" >/dev/null 2>&1 || true
fi

echo "installed: $prefix"
echo "launch:    $prefix/whocode  (or the whocode entry in your app menu)"
echo "remove:    rm -rf \"$prefix\" \"$data/applications/whocode.desktop\" \"$data/icons/hicolor/512x512/apps/whocode.png\""