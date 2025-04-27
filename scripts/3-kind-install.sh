#!/usr/bin/env bash

echo "[Running kind-install.sh]"

KIND_VERSION="v0.27.0"  # Update this to the version you want to install
OS=$(uname)
ARCH=$(uname -m)

# Map architecture names
if [ "$ARCH" = "x86_64" ]; then
    ARCH="amd64"
elif [ "$ARCH" = "aarch64" ]; then
    ARCH="arm64"
fi

echo "Detected OS: $OS, Architecture: $ARCH"
echo "Installing kind $KIND_VERSION for $OS-$ARCH"

# Download and install kind
sudo curl -L "https://kind.sigs.k8s.io/dl/$KIND_VERSION/kind-$OS-$ARCH" -o /usr/local/bin/kind
sudo chmod +x /usr/local/bin/kind

# Verify installation
echo "Installation complete. Verifying kind version:"
kind version
