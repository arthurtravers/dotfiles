#!/bin/bash

echo "🚀 Setting up Claude Code, Codex, and MCP servers..."

# Exit on error
set -e

# Error handler
handle_error() {
    echo "❌ Error occurred at line $1"
    echo "💡 Continuing setup despite error..."
}
trap 'handle_error $LINENO' ERR

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# --- VERSION MANAGEMENT ---
echo "📦 Setting up version managers..."

# Install NVM (Node Version Manager)
if ! command -v nvm &> /dev/null; then
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash || true
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

    # Install latest LTS Node
    nvm install --lts || true
    nvm use --lts || true
fi

# Install pyenv for Python version management
if ! command -v pyenv &> /dev/null; then
    echo "Installing pyenv..."
    curl https://pyenv.run | bash || true
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)" || true
    eval "$(pyenv virtualenv-init -)" || true
fi

# Continue without exit on error for optional components
set +e

# Install Python tools
echo "📦 Installing Python tools..."
pip install --user pipx 2>/dev/null || python3 -m pip install --user pipx || echo "⚠️ pipx installation failed"
export PATH="$PATH:$HOME/.local/bin"
python3 -m pipx ensurepath 2>/dev/null || true

# Install UV for Python package management
echo "📦 Installing UV package manager..."
curl -LsSf https://astral.sh/uv/install.sh | sh 2>/dev/null || echo "⚠️ UV installation failed"
source $HOME/.cargo/env 2>/dev/null || true

# Install Claude Code and Codex CLIs
echo "📦 Installing Claude Code and Codex CLIs..."
npm install -g @anthropic-ai/claude-code 2>/dev/null || echo "⚠️ Claude Code CLI installation failed"
npm install -g @openai/codex 2>/dev/null || echo "⚠️ Codex CLI installation failed"

# Install Playwright browsers for headless automation
echo "🎭 Installing Playwright browsers..."
npx playwright install chromium 2>/dev/null || echo "⚠️ Playwright installation failed"

# --- CLAUDE AUTHENTICATION ---
echo "🔐 Setting up Claude authentication..."
mkdir -p ~/.claude 2>/dev/null || true

if [ -f "$SCRIPT_DIR/claude-template.json" ]; then
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
else
  echo "⚠️ Claude template not found at $SCRIPT_DIR/claude-template.json"
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
echo "🔐 Setting up Codex authentication..."
mkdir -p ~/.codex 2>/dev/null || true

if [ -f "$SCRIPT_DIR/codex-auth-template.json" ]; then
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
else
  echo "⚠️ Codex template not found at $SCRIPT_DIR/codex-auth-template.json"
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

# Check installation status
echo "📊 Installation Status:"
echo "─────────────────────"

# Check CLI tools
if command -v claude &> /dev/null; then
  echo "✅ Claude Code CLI"
else
  echo "❌ Claude Code CLI - Run: npm install -g @anthropic-ai/claude-code"
fi

if command -v codex &> /dev/null; then
  echo "✅ Codex CLI"
else
  echo "❌ Codex CLI - Run: npm install -g @openai/codex"
fi

# Check version managers
if command -v nvm &> /dev/null || [ -f "$HOME/.nvm/nvm.sh" ]; then
  echo "✅ NVM (Node Version Manager)"
else
  echo "⚠️ NVM not installed"
fi

if command -v pyenv &> /dev/null || [ -f "$HOME/.pyenv/bin/pyenv" ]; then
  echo "✅ pyenv (Python Version Manager)"
else
  echo "⚠️ pyenv not installed"
fi

# Check authentication
if [ -n "$CLAUDE_ACCOUNT_UUID" ]; then
  echo "✅ Claude authentication configured"
else
  echo "⚠️ Claude needs manual login: claude login"
fi

if [ -n "$CODEX_ID_TOKEN" ]; then
  echo "✅ Codex authentication configured"
else
  echo "⚠️ Codex needs manual login: codex login"
fi

echo ""
echo "📝 Quick Start:"
echo "   Terminal: claude | codex"
echo "   VSCode: Look for AI icons in sidebar"
echo ""

if [ -n "$CLAUDE_ACCOUNT_UUID" ] && [ -n "$CODEX_ID_TOKEN" ]; then
  echo "✅ All AI tools authenticated and ready!"
else
  echo "💡 Add missing secrets at github.com/settings/codespaces"
fi