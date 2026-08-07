#!/data/data/com.termux/files/usr/bin/bash

set -e

APP_NAME="sxbops"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==================================="
echo "        SXB OPS INSTALLER"
echo "==================================="
echo

ARCH="$(uname -m)"

# Detect Termux
if [ -n "$PREFIX" ] && [ -d "$PREFIX/bin" ]; then

    echo "[+] Environment : Termux"
    echo "[+] Architecture: $ARCH"
    echo

    if [ "$ARCH" != "aarch64" ]; then
        echo "[!] Unsupported Termux architecture: $ARCH"
        exit 1
    fi

    if [ ! -f "$SCRIPT_DIR/sxbops" ]; then
        echo "[!] Termux binary not found."
        exit 1
    fi

    echo "[+] Installing $APP_NAME..."

    cp "$SCRIPT_DIR/sxbops" "$PREFIX/bin/$APP_NAME"
    chmod 755 "$PREFIX/bin/$APP_NAME"

    echo
    echo "[+] Installation completed."
    echo
    echo "Run the program with:"
    echo
    echo "    $APP_NAME"
    echo

    exit 0
fi

# Linux
if [ "$(uname -s)" = "Linux" ]; then

    echo "[+] Environment : Linux"
    echo "[+] Architecture: $ARCH"
    echo

    case "$ARCH" in

        x86_64|amd64)
            BINARY="$SCRIPT_DIR/sxbops-linux-amd64"
            ;;

        aarch64|arm64)
            BINARY="$SCRIPT_DIR/sxbops-linux-arm64"
            ;;

        *)
            echo "[!] Unsupported architecture: $ARCH"
            exit 1
            ;;
    esac

    if [ ! -f "$BINARY" ]; then
        echo "[!] Required binary not found:"
        echo "    $BINARY"
        exit 1
    fi

    INSTALL_DIR="/usr/local/bin"

    echo "[+] Installing $APP_NAME to $INSTALL_DIR..."

    if [ ! -w "$INSTALL_DIR" ]; then
        if command -v sudo >/dev/null 2>&1; then
            sudo cp "$BINARY" "$INSTALL_DIR/$APP_NAME"
            sudo chmod 755 "$INSTALL_DIR/$APP_NAME"
        else
            echo "[!] sudo is required to install into $INSTALL_DIR."
            echo "[!] Run this installer with appropriate permissions."
            exit 1
        fi
    else
        cp "$BINARY" "$INSTALL_DIR/$APP_NAME"
        chmod 755 "$INSTALL_DIR/$APP_NAME"
    fi

    echo
    echo "[+] Installation completed."
    echo
    echo "Run the program with:"
    echo
    echo "    $APP_NAME"
    echo

    exit 0
fi

echo "[!] Unsupported operating system."
exit 1