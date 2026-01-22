#!/usr/bin/env bash
set -euo pipefail

# neovide-install.sh
# Installe la derniere Neovide AppImage + .desktop + icone

MODE="user"            # user | system
ICON_PATH=""           # chemin vers neovide.png
BIN_NAME="neovide"
APP_NAME="Neovide"
DESKTOP_ID="neovide"
REPO="neovide/neovide"

usage() {
  cat <<'EOF'
Usage:
  ./neovide-install.sh [--system] [--icon /path/neovide.png]

Par defaut (sans --system), installe en mode user:
  - AppImage -> ~/.local/bin/neovide
  - .desktop -> ~/.local/share/applications/neovide.desktop
  - icone    -> ~/.local/share/icons/hicolor/256x256/apps/neovide.png

Mode system (--system) (necessite sudo):
  - AppImage -> /usr/local/bin/neovide
  - .desktop -> /usr/local/share/applications/neovide.desktop
  - icone    -> /usr/local/share/icons/hicolor/256x256/apps/neovide.png
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --system) MODE="system"; shift ;;
    --icon) ICON_PATH="${2:-}"; shift 2 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Option inconnue: $1"; usage; exit 1 ;;
  esac
done

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || { echo "Erreur: '$1' est requis."; exit 1; }
}

need_cmd curl
need_cmd grep
need_cmd sed
need_cmd uname
need_cmd mkdir
need_cmd chmod
need_cmd rm
need_cmd mv

ARCH="$(uname -m)"
case "$ARCH" in
  x86_64|amd64) ASSET_HINT="x86_64" ;;
  aarch64|arm64) ASSET_HINT="aarch64" ;;
  *)
    echo "Arch non supportee automatiquement: $ARCH"
    echo "Tu peux adapter ASSET_HINT dans le script si besoin."
    exit 1
    ;;
esac

if [[ -z "$ICON_PATH" ]]; then
  # cherche neovide.png dans le dossier du script
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  if [[ -f "$SCRIPT_DIR/neovide.png" ]]; then
    ICON_PATH="$SCRIPT_DIR/neovide.png"
  fi
fi

if [[ "$MODE" == "system" ]]; then
  need_cmd sudo
  BIN_DIR="/usr/local/bin"
  APP_DIR="/usr/local/share/applications"
  ICON_DIR="/usr/local/share/icons/hicolor/256x256/apps"
  INSTALL_AS="sudo"
else
  BIN_DIR="$HOME/.local/bin"
  APP_DIR="$HOME/.local/share/applications"
  ICON_DIR="$HOME/.local/share/icons/hicolor/256x256/apps"
  INSTALL_AS=""
fi

mkdir -p "$BIN_DIR" "$APP_DIR" "$ICON_DIR"

TMP_DIR="$(mktemp -d)"
cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT

echo "-> Recuperation du JSON des releases ($REPO)..."
JSON="$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest")"

# Extrait un URL d'asset AppImage correspondant a l'arch, en evitant les signatures .zsync/.sha256 etc.
# On prend le premier match raisonnable.
ASSET_URL="$(printf '%s' "$JSON" \
  | grep -Eo 'https://github\.com/'"$REPO"'/releases/download/[^"]+\.AppImage' \
  | grep -i "$ASSET_HINT" \
  | head -n 1 || true)"

# Fallback: si pas de match arch, prend n'importe quelle AppImage
if [[ -z "$ASSET_URL" ]]; then
  ASSET_URL="$(printf '%s' "$JSON" \
    | grep -Eo 'https://github\.com/'"$REPO"'/releases/download/[^"]+\.AppImage' \
    | head -n 1 || true)"
fi

if [[ -z "$ASSET_URL" ]]; then
  echo "Erreur: impossible de trouver une AppImage dans la release latest."
  echo "API JSON peut etre rate-limitee ou format change."
  exit 1
fi

echo "-> AppImage trouvee:"
echo "   $ASSET_URL"

APPIMAGE_TMP="$TMP_DIR/neovide.AppImage"
echo "-> Telechargement..."
curl -fL --retry 3 --retry-delay 1 -o "$APPIMAGE_TMP" "$ASSET_URL"

echo "-> Installation binaire dans $BIN_DIR/$BIN_NAME"
if [[ -n "$INSTALL_AS" ]]; then
  sudo mv "$APPIMAGE_TMP" "$BIN_DIR/$BIN_NAME"
  sudo chmod +x "$BIN_DIR/$BIN_NAME"
else
  mv "$APPIMAGE_TMP" "$BIN_DIR/$BIN_NAME"
  chmod +x "$BIN_DIR/$BIN_NAME"
fi

# Icône
if [[ -n "$ICON_PATH" && -f "$ICON_PATH" ]]; then
  echo "-> Copie icone: $ICON_PATH -> $ICON_DIR/$DESKTOP_ID.png"
  if [[ -n "$INSTALL_AS" ]]; then
    sudo cp "$ICON_PATH" "$ICON_DIR/$DESKTOP_ID.png"
  else
    cp "$ICON_PATH" "$ICON_DIR/$DESKTOP_ID.png"
  fi
else
  echo "(!) Icône non fournie/trouvee. Passe --icon /chemin/neovide.png si tu veux."
fi

# .desktop
DESKTOP_PATH="$APP_DIR/$DESKTOP_ID.desktop"
echo "-> Creation .desktop: $DESKTOP_PATH"

DESKTOP_CONTENT="[Desktop Entry]
Type=Application
Name=$APP_NAME
Comment=Neovim GUI
TryExec=$BIN_DIR/$BIN_NAME
Exec=$BIN_DIR/$BIN_NAME %F
Icon=$DESKTOP_ID
Terminal=false
Categories=Development;Editor;
StartupWMClass=neovide
MimeType=text/plain;
"

if [[ -n "$INSTALL_AS" ]]; then
  printf '%s' "$DESKTOP_CONTENT" | sudo tee "$DESKTOP_PATH" >/dev/null
else
  printf '%s' "$DESKTOP_CONTENT" > "$DESKTOP_PATH"
fi

# Refresh (best effort)
echo "-> Refresh desktop database (si dispo)..."
if command -v update-desktop-database >/dev/null 2>&1; then
  if [[ -n "$INSTALL_AS" ]]; then
    sudo update-desktop-database "$APP_DIR" >/dev/null 2>&1 || true
  else
    update-desktop-database "$APP_DIR" >/dev/null 2>&1 || true
  fi
fi

echo "✅ OK. Tu devrais voir '$APP_NAME' dans ton menu d'applications."
echo "Astuce: si elle n'apparait pas, logout/login ou redemarre ton shell/DE."

