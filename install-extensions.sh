#!/bin/bash

# VSCode Extension Installer for Codespaces
# This can be run manually after Codespace is fully ready

echo "🔍 Checking for VSCode CLI..."

# Find the code command
CODE_CMD=""
if command -v code &> /dev/null; then
    CODE_CMD="code"
elif [ -f "/vscode/bin/linux-x64/bin/code-server" ]; then
    CODE_CMD="/vscode/bin/linux-x64/bin/code-server"
else
    echo "❌ VSCode CLI not found"
    echo "   Please run this script after VSCode is fully loaded"
    exit 1
fi

echo "✅ Found VSCode CLI at: $CODE_CMD"
echo ""
echo "📦 Installing VSCode extensions..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Extension list with descriptions
declare -a EXTENSIONS=(
    "anthropic.claude-code:Claude for VS Code"
    "openai.chatgpt:ChatGPT"
    "ms-playwright.playwright:Playwright Test"
    "rangav.vscode-thunder-client:Thunder Client"
    "humao.rest-client:REST Client"
    "ms-azuretools.vscode-docker:Docker"
    "ms-vscode-remote.remote-containers:Dev Containers"
    "sonarsource.sonarlint-vscode:SonarLint"
    "usernamehw.errorlens:Error Lens"
    "streetsidesoftware.code-spell-checker:Spell Checker"
    "esbenp.prettier-vscode:Prettier"
    "ms-python.python:Python"
    "eamodio.gitlens:GitLens"
)

TOTAL=${#EXTENSIONS[@]}
INSTALLED=0
FAILED=0

for i in "${!EXTENSIONS[@]}"; do
    IFS=':' read -r EXT_ID EXT_NAME <<< "${EXTENSIONS[$i]}"
    PROGRESS=$((i + 1))

    echo -n "[$PROGRESS/$TOTAL] Installing $EXT_NAME... "

    if $CODE_CMD --install-extension "$EXT_ID" --force &> /dev/null; then
        echo "✅"
        ((INSTALLED++))
    else
        echo "❌"
        ((FAILED++))
    fi
done

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📊 Installation Summary:"
echo "   ✅ Installed: $INSTALLED"
echo "   ❌ Failed: $FAILED"
echo ""

if [ $INSTALLED -gt 0 ]; then
    echo "🎉 Extensions installed successfully!"
    echo "   You may need to reload VSCode for all extensions to activate"
    echo ""
    echo "💡 Reload VSCode:"
    echo "   Press Cmd/Ctrl + Shift + P → 'Developer: Reload Window'"
fi

if [ $FAILED -gt 0 ]; then
    echo ""
    echo "⚠️ Some extensions failed to install"
    echo "   This might be due to network issues or extension availability"
    echo "   You can try installing them manually from the Extensions sidebar"
fi