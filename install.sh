#!/bin/bash

# Automatic Codespace Configuration for Claude Code, Codex, and MCP Servers
# This script runs automatically when you create any GitHub Codespace if dotfiles are enabled

echo "🚀 Starting automatic Codespace configuration..."

# Only run in GitHub Codespaces environment
if [ "$CODESPACES" != "true" ]; then
    echo "Not in a Codespace environment. Exiting..."
    exit 0
fi

# Run our setup script directly from dotfiles
echo "🎯 Running setup script..."
bash ~/dotfiles/codespace-config/setup.sh

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