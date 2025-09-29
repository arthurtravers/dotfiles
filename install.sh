#!/bin/bash

# Automatic Codespace Configuration for Claude Code, Codex, and MCP Servers
# This script runs automatically when you create any GitHub Codespace if dotfiles are enabled

echo "🚀 Starting automatic Codespace configuration..."

# Only run in GitHub Codespaces environment
if [ "$CODESPACES" != "true" ]; then
    echo "Not in a Codespace environment. Exiting..."
    exit 0
fi

# Get the workspace directory
WORKSPACE_DIR="/workspaces/${CODESPACE_VSCODE_FOLDER:-$RepositoryName}"

# Check if .devcontainer already exists in the repository
if [ -d "$WORKSPACE_DIR/.devcontainer" ]; then
    echo "⚠️  .devcontainer already exists in this repository. Skipping automatic setup to avoid conflicts."
    echo "💡 Tip: If you want to use the dotfiles configuration, remove the existing .devcontainer folder."
else
    echo "📦 Deploying .devcontainer configuration..."

    # Create .devcontainer directory in the workspace
    mkdir -p "$WORKSPACE_DIR/.devcontainer"

    # Copy configuration files from dotfiles to workspace
    cp -r ~/dotfiles/codespace-config/* "$WORKSPACE_DIR/.devcontainer/"

    echo "✅ .devcontainer configuration deployed!"
    echo "🎯 Running setup script..."

    # Run the setup script
    bash "$WORKSPACE_DIR/.devcontainer/setup.sh"
fi

echo "🎉 Codespace configuration complete!"
echo ""
echo "📝 Available tools:"
echo "   - Claude Code: type 'claude'"
echo "   - Codex: type 'codex'"
echo ""
echo "🔧 MCP Servers configured:"
echo "   - Memory, Sequential Thinking, Filesystem"
echo "   - Supabase, Netlify, Vercel, Sentry"
echo "   - Playwright (headless), Brave Search"
echo "   - Context7, Fetch, Everything, Analytics"
echo ""
echo "💡 Note: Authentication tokens are loaded from GitHub Codespace Secrets"