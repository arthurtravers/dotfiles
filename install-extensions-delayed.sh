#!/bin/bash

# VSCode Extension Auto-Installer for Codespaces
# Waits for VSCode to be ready, then installs extensions

echo "🔄 Waiting for VSCode to be ready..."

# Wait up to 5 minutes (300 seconds) for code CLI to be available
MAX_WAIT=300
WAITED=0

while [ $WAITED -lt $MAX_WAIT ]; do
    if command -v code &> /dev/null; then
        echo "✅ VSCode is ready!"
        break
    fi
    sleep 10
    WAITED=$((WAITED + 10))
    echo "   Waiting... ($WAITED/$MAX_WAIT seconds)"
done

if ! command -v code &> /dev/null; then
    echo "⚠️ VSCode CLI still not available after $MAX_WAIT seconds"
    echo "   Extensions will be installed when you manually run:"
    echo "   ~/dotfiles/install-extensions.sh"
    exit 1
fi

# Install extensions
echo "📦 Installing VSCode extensions..."

EXTENSIONS=(
    "anthropic.claude-code"
    "ms-playwright.playwright"
    "rangav.vscode-thunder-client"
    "humao.rest-client"
    "ms-azuretools.vscode-docker"
    "ms-vscode-remote.remote-containers"
    "sonarsource.sonarlint-vscode"
    "usernamehw.errorlens"
    "streetsidesoftware.code-spell-checker"
    "esbenp.prettier-vscode"
    "ms-python.python"
    "eamodio.gitlens"
)

for ext in "${EXTENSIONS[@]}"; do
    code --install-extension "$ext" --force &> /dev/null &
done

# Wait for all background installations to complete
wait

echo "✅ Extension installation initiated!"
echo "   Extensions will appear in the sidebar shortly"