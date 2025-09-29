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

# Start VSCode extension installation in background
echo "📦 Scheduling VSCode extension installation..."
chmod +x "$DOTFILES_DIR/install-extensions-delayed.sh" 2>/dev/null || true

# Run the delayed installer in background
nohup bash "$DOTFILES_DIR/install-extensions-delayed.sh" > /tmp/vscode-extensions.log 2>&1 &
echo "   Extensions will install automatically when VSCode is ready"
echo "   Check progress: tail -f /tmp/vscode-extensions.log"

echo "🎉 Codespace configuration complete!"
echo ""
echo "📝 Available AI Tools:"
echo ""
echo "🖥️ Terminal Commands:"
echo "   - claude  → Claude Code CLI"
echo "   - codex   → Codex CLI"
echo ""

echo "🎨 VSCode Extensions (installing in background):"
echo "   - Claude for VS Code → Chat with Claude"
echo "   - ChatGPT → OpenAI's ChatGPT"
echo "   - Prettier, GitLens, Python, Docker"
echo "   - And 9 more essential tools..."
echo ""
echo "   📊 Check installation: tail -f /tmp/vscode-extensions.log"
echo "   🔄 Manual install: ~/dotfiles/install-extensions.sh"
echo ""

echo "🔧 MCP Servers configured:"
echo "   - Memory, Sequential Thinking, Filesystem"
echo "   - Supabase, Netlify, Vercel, Sentry"
echo "   - Playwright (headless), Brave Search"
echo "   - Context7, Fetch, Everything, Analytics"
echo ""
echo "💡 Note: Authentication tokens are loaded from GitHub Codespace Secrets"