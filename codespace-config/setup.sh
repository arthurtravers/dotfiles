#!/bin/bash

echo "🚀 Setting up Claude Code, Codex, and MCP servers..."

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Install Python tools
pip install --user pipx 2>/dev/null || python3 -m pip install --user pipx
export PATH="$PATH:$HOME/.local/bin"
python3 -m pipx ensurepath

# Install UV for Python package management
curl -LsSf https://astral.sh/uv/install.sh | sh
source $HOME/.cargo/env

# Install Claude Code and Codex CLIs
echo "📦 Installing Claude Code and Codex CLIs..."
npm install -g @anthropic/claude-code 2>/dev/null || echo "⚠️ Claude Code CLI installation failed"
npm install -g @openai/codex 2>/dev/null || echo "⚠️ Codex CLI installation failed"

# Install Playwright browsers for headless automation
npx playwright install chromium

# --- CLAUDE AUTHENTICATION ---
mkdir -p ~/.claude 2>/dev/null
cp "$SCRIPT_DIR/claude-template.json" ~/.claude.json

# Replace placeholders with GitHub Secrets if they exist
if [ -n "$CLAUDE_ACCOUNT_UUID" ]; then
  sed -i "s/CLAUDE_ACCOUNT_UUID/$CLAUDE_ACCOUNT_UUID/g" ~/.claude.json
  sed -i "s/CLAUDE_EMAIL/$CLAUDE_EMAIL/g" ~/.claude.json
  sed -i "s/CLAUDE_ORG_UUID/$CLAUDE_ORG_UUID/g" ~/.claude.json
  # Escape org name for sed
  CLAUDE_ORG_NAME_ESC=$(printf '%s\n' "$CLAUDE_ORG_NAME" | sed 's/[[\.*^$()+?{|]/\\&/g')
  sed -i "s/CLAUDE_ORG_NAME/$CLAUDE_ORG_NAME_ESC/g" ~/.claude.json
  sed -i "s/CLAUDE_DISPLAY_NAME/$CLAUDE_DISPLAY_NAME/g" ~/.claude.json
  echo "✅ Claude authenticated automatically!"
else
  echo "⚠️ Claude OAuth secrets not found. You'll need to run: claude login"
  echo "💡 Add CLAUDE_* secrets at github.com/settings/codespaces for auto-auth"
fi

# Replace API tokens for MCP servers
if [ -n "$SUPABASE_ACCESS_TOKEN" ]; then
  sed -i "s/SUPABASE_ACCESS_TOKEN/$SUPABASE_ACCESS_TOKEN/g" ~/.claude.json
fi

if [ -n "$NETLIFY_TOKEN" ]; then
  sed -i "s/NETLIFY_TOKEN/$NETLIFY_TOKEN/g" ~/.claude.json
fi

if [ -n "$BRAVE_API_KEY" ]; then
  sed -i "s/BRAVE_API_KEY/$BRAVE_API_KEY/g" ~/.claude.json
fi

if [ -n "$HF_TOKEN" ]; then
  sed -i "s/HF_TOKEN/$HF_TOKEN/g" ~/.claude.json
fi

# --- CODEX AUTHENTICATION ---
mkdir -p ~/.codex
cp "$SCRIPT_DIR/codex-auth-template.json" ~/.codex/auth.json

if [ -n "$CODEX_ID_TOKEN" ]; then
  # Escape special characters in tokens for sed
  CODEX_ID_ESC=$(printf '%s\n' "$CODEX_ID_TOKEN" | sed 's/[[\.*^$()+?{|]/\\&/g')
  CODEX_ACCESS_ESC=$(printf '%s\n' "$CODEX_ACCESS_TOKEN" | sed 's/[[\.*^$()+?{|]/\\&/g')

  sed -i "s|CODEX_ID_TOKEN|$CODEX_ID_ESC|g" ~/.codex/auth.json
  sed -i "s|CODEX_ACCESS_TOKEN|$CODEX_ACCESS_ESC|g" ~/.codex/auth.json
  sed -i "s/CODEX_REFRESH_TOKEN/$CODEX_REFRESH_TOKEN/g" ~/.codex/auth.json
  sed -i "s/CODEX_ACCOUNT_ID/$CODEX_ACCOUNT_ID/g" ~/.codex/auth.json
  echo "✅ Codex authenticated automatically!"
else
  echo "⚠️ Codex OAuth secrets not found. You'll need to run: codex login"
  echo "💡 Add CODEX_* secrets at github.com/settings/codespaces for auto-auth"
fi

# Pre-cache commonly used MCP servers to speed up first use
echo "📦 Pre-caching MCP servers..."
npx -y @modelcontextprotocol/server-filesystem --version > /dev/null 2>&1 &
npx -y @modelcontextprotocol/server-memory --version > /dev/null 2>&1 &
npx -y @modelcontextprotocol/server-github --version > /dev/null 2>&1 &
wait

echo ""
echo "🎉 Setup complete!"
echo ""
echo "📝 Usage:"
echo "   - Claude Code: type 'claude'"
echo "   - Codex: type 'codex'"
echo ""
if [ -n "$CLAUDE_ACCOUNT_UUID" ] && [ -n "$CODEX_ID_TOKEN" ]; then
  echo "✅ Both tools are authenticated and ready to use!"
else
  echo "⚠️ Some tools need manual authentication. Check messages above."
fi