#!/bin/bash

# Automatic Codespace Configuration for Claude Code, Codex, and MCP Servers
# This script runs automatically when you create any GitHub Codespace if dotfiles are enabled

echo "🚀 Starting automatic Codespace configuration..."

# Only run in GitHub Codespaces environment
if [ "$CODESPACES" != "true" ]; then
    echo "Not in a Codespace environment. Exiting..."
    exit 0
fi

# Find the dotfiles directory (it can be in different locations)
if [ -d "/workspaces/.codespaces/.persistedshare/dotfiles" ]; then
    DOTFILES_DIR="/workspaces/.codespaces/.persistedshare/dotfiles"
elif [ -d "$HOME/dotfiles" ]; then
    DOTFILES_DIR="$HOME/dotfiles"
elif [ -d "$(dirname "$0")" ]; then
    # Use the directory where this script is located
    DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
else
    echo "❌ Cannot find dotfiles directory!"
    echo "   Searched: /workspaces/.codespaces/.persistedshare/dotfiles"
    echo "   Searched: $HOME/dotfiles"
    echo "   Searched: $(dirname "$0")"
    exit 1
fi

echo "📁 Using dotfiles from: $DOTFILES_DIR"

# Run our setup script directly from dotfiles
echo "🎯 Running setup script..."
bash "$DOTFILES_DIR/codespace-config/setup.sh"

# Install VSCode extensions if code CLI is available
if command -v code &> /dev/null; then
    echo "📦 Installing VSCode extensions..."
    echo "   (This may take a minute...)"

    # Track successes and failures
    INSTALLED=0
    FAILED=0

    # AI Extensions
    echo "   Installing AI assistants..."
    code --install-extension anthropic.claude-code && ((INSTALLED++)) || ((FAILED++))
    code --install-extension openai.chatgpt && ((INSTALLED++)) || ((FAILED++))
    code --install-extension github.copilot && ((INSTALLED++)) || ((FAILED++))
    code --install-extension github.copilot-chat && ((INSTALLED++)) || ((FAILED++))

    # Testing & Automation
    echo "   Installing testing tools..."
    code --install-extension ms-playwright.playwright && ((INSTALLED++)) || ((FAILED++))

    # API Testing
    echo "   Installing API testing tools..."
    code --install-extension rangav.vscode-thunder-client && ((INSTALLED++)) || ((FAILED++))
    code --install-extension humao.rest-client && ((INSTALLED++)) || ((FAILED++))

    # Docker
    echo "   Installing Docker tools..."
    code --install-extension ms-azuretools.vscode-docker && ((INSTALLED++)) || ((FAILED++))
    code --install-extension ms-vscode-remote.remote-containers && ((INSTALLED++)) || ((FAILED++))

    # Security & Quality
    echo "   Installing security & quality tools..."
    code --install-extension sonarsource.sonarlint-vscode && ((INSTALLED++)) || ((FAILED++))
    code --install-extension usernamehw.errorlens && ((INSTALLED++)) || ((FAILED++))
    code --install-extension streetsidesoftware.code-spell-checker && ((INSTALLED++)) || ((FAILED++))

    # Core Development Extensions
    echo "   Installing core development tools..."
    code --install-extension esbenp.prettier-vscode && ((INSTALLED++)) || ((FAILED++))
    code --install-extension dbaeumer.vscode-eslint && ((INSTALLED++)) || ((FAILED++))
    code --install-extension ms-python.python && ((INSTALLED++)) || ((FAILED++))
    code --install-extension eamodio.gitlens && ((INSTALLED++)) || ((FAILED++))
    code --install-extension mhutchie.git-graph && ((INSTALLED++)) || ((FAILED++))
    code --install-extension wayou.vscode-todo-highlight && ((INSTALLED++)) || ((FAILED++))
    code --install-extension gruntfuggly.todo-tree && ((INSTALLED++)) || ((FAILED++))

    echo "✅ VSCode extensions: $INSTALLED installed, $FAILED failed"

    # Show which extensions are actually installed
    echo "   Verifying installed extensions..."
    code --list-extensions | head -10
else
    echo "ℹ️ VSCode CLI not found, skipping extension installation"
    echo "   Checking for code-server alternative..."

    # In Codespaces, the code CLI might be at a different location
    if [ -f "/vscode/bin/linux-x64/bin/code-server" ]; then
        echo "   Found code-server, attempting extension installation..."
        /vscode/bin/linux-x64/bin/code-server --install-extension anthropic.claude-code || true
    fi
fi

echo "🎉 Codespace configuration complete!"
echo ""
echo "📝 Available AI Tools:"
echo ""
echo "🖥️ Terminal Commands:"
echo "   - claude  → Claude Code CLI"
echo "   - codex   → Codex CLI"
echo ""

# Check if extensions were installed
if command -v code &> /dev/null; then
    EXTENSION_COUNT=$(code --list-extensions 2>/dev/null | wc -l)
    if [ "$EXTENSION_COUNT" -gt 5 ]; then
        echo "🎨 VSCode Extensions (in sidebar):"
        echo "   - Claude for VS Code → Chat with Claude"
        echo "   - ChatGPT → OpenAI's ChatGPT"
        echo "   - GitHub Copilot → AI pair programming"
        echo ""
    else
        echo "⚠️ VSCode extensions may not be installed yet"
        echo "   Run this after VSCode loads: ~/dotfiles/install-extensions.sh"
        echo ""
    fi
else
    echo "⚠️ VSCode extensions pending (code CLI not available yet)"
    echo "   Run this after VSCode loads: ~/dotfiles/install-extensions.sh"
    echo ""
fi

echo "🔧 MCP Servers configured:"
echo "   - Memory, Sequential Thinking, Filesystem"
echo "   - Supabase, Netlify, Vercel, Sentry"
echo "   - Playwright (headless), Brave Search"
echo "   - Context7, Fetch, Everything, Analytics"
echo ""
echo "💡 Note: Authentication tokens are loaded from GitHub Codespace Secrets"