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

    # AI Extensions
    code --install-extension anthropic.claude-code 2>/dev/null || true
    code --install-extension openai.chatgpt 2>/dev/null || true
    code --install-extension github.copilot 2>/dev/null || true
    code --install-extension github.copilot-chat 2>/dev/null || true

    # Core Development Extensions
    code --install-extension esbenp.prettier-vscode 2>/dev/null || true
    code --install-extension dbaeumer.vscode-eslint 2>/dev/null || true
    code --install-extension ms-python.python 2>/dev/null || true
    code --install-extension eamodio.gitlens 2>/dev/null || true

    echo "✅ VSCode extensions installed!"
else
    echo "ℹ️ VSCode CLI not found, skipping extension installation"
fi

echo "🎉 Codespace configuration complete!"
echo ""
echo "📝 Available AI Tools:"
echo ""
echo "🖥️ Terminal Commands:"
echo "   - claude  → Claude Code CLI"
echo "   - codex   → Codex CLI"
echo ""
echo "🎨 VSCode Extensions (in sidebar):"
echo "   - Claude for VS Code → Chat with Claude"
echo "   - ChatGPT → OpenAI's ChatGPT"
echo "   - GitHub Copilot → AI pair programming"
echo ""
echo "🔧 MCP Servers configured:"
echo "   - Memory, Sequential Thinking, Filesystem"
echo "   - Supabase, Netlify, Vercel, Sentry"
echo "   - Playwright (headless), Brave Search"
echo "   - Context7, Fetch, Everything, Analytics"
echo ""
echo "💡 Note: Authentication tokens are loaded from GitHub Codespace Secrets"