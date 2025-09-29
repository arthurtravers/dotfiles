# 🚀 Automatic Codespace Configuration

Automatically configures every GitHub Codespace with **Claude Code**, **Codex**, and **13+ MCP servers** - no manual setup needed!

## ✨ What This Does

When you create ANY GitHub Codespace with this dotfiles setup:

1. **Automatically installs**:
   - 🤖 Claude Code CLI (`claude`)
   - 🧠 Codex CLI (`codex`)
   - 📦 13+ MCP (Model Context Protocol) servers

2. **Auto-authenticates** both CLIs using GitHub Secrets (optional)

3. **Works on**:
   - 💻 Desktop browser
   - 📱 Mobile (iPhone/Android via GitHub app)
   - 🖥️ Tablets/iPads

## 🎯 Features

### AI Tools Included
- **Claude Code**: Anthropic's AI coding assistant
- **Codex**: OpenAI's code completion tool

### MCP Servers Included
- **Core**: Memory, Sequential Thinking, Filesystem, Fetch
- **Cloud Services**: Supabase, Netlify, Vercel, Sentry
- **Search & Data**: Brave Search, Context7
- **Automation**: Playwright (headless browser)
- **Analytics**: Google Analytics MCP
- **Development**: GitHub, Hugging Face, Everything (testing)

## 📋 Prerequisites

You'll need:
1. GitHub account
2. Claude account (for Claude Code)
3. OpenAI account (for Codex)
4. API keys for MCP servers you want to use

## 🔧 Setup Instructions

### Step 1: Fork This Repository

1. Click "Fork" on this repository
2. Name it `dotfiles` (must be exactly this name)
3. Keep it public or make it private (both work)

### Step 2: Add GitHub Secrets (Optional but Recommended)

Go to [github.com/settings/codespaces](https://github.com/settings/codespaces) and add these secrets:

#### Claude Authentication (Auto-login)
- `CLAUDE_ACCOUNT_UUID` - Your Claude account UUID
- `CLAUDE_EMAIL` - Your Claude email
- `CLAUDE_ORG_UUID` - Your Claude organization UUID
- `CLAUDE_ORG_NAME` - Your Claude organization name
- `CLAUDE_DISPLAY_NAME` - Your display name

#### Codex Authentication (Auto-login)
- `CODEX_ID_TOKEN` - Your Codex ID token
- `CODEX_ACCESS_TOKEN` - Your Codex access token
- `CODEX_REFRESH_TOKEN` - Your Codex refresh token
- `CODEX_ACCOUNT_ID` - Your Codex account ID

#### MCP Server API Keys (As Needed)
- `SUPABASE_ACCESS_TOKEN` - Supabase access token
- `NETLIFY_TOKEN` - Netlify personal access token
- `BRAVE_API_KEY` - Brave Search API key
- `HF_TOKEN` - Hugging Face token
- `GITHUB_TOKEN` - GitHub personal access token (usually auto-provided)

> 💡 **Note**: Without these secrets, you'll need to manually authenticate with `claude login` and `codex login`

### Step 3: Enable Dotfiles in GitHub

1. Go to [github.com/settings/codespaces](https://github.com/settings/codespaces)
2. Find "Dotfiles" section
3. Check ✅ **"Automatically install dotfiles"**
4. Select your forked `dotfiles` repository

### Step 4: Create a Codespace

1. Go to any repository
2. Click green "Code" button → "Codespaces" → "Create codespace"
3. Wait 2-3 minutes for first-time setup
4. Everything is automatically configured! 🎉

## 🎮 Usage

Once your Codespace is ready:

```bash
# Use Claude Code
claude

# Use Codex
codex

# Both are pre-authenticated if you added secrets!
```

## 📱 Mobile Usage

1. Open GitHub mobile app
2. Navigate to your repository
3. Tap "Code" → "Codespaces"
4. Open your Codespace
5. Works in mobile browser with full functionality!

## 🔍 How It Works

1. **GitHub's dotfiles feature** automatically clones this repo to `~/dotfiles` in every Codespace
2. **install.sh** runs automatically and:
   - Checks if `.devcontainer` already exists (skips if yes)
   - Deploys configuration if not present
   - Installs all CLIs and dependencies
   - Configures authentication from secrets

## 🛠️ Customization

### Add More MCP Servers

Edit `codespace-config/claude-template.json` to add more MCP servers:

```json
"your-server": {
  "command": "npx",
  "args": ["-y", "@your-org/your-mcp-server"],
  "env": {
    "YOUR_API_KEY": "YOUR_API_KEY"
  }
}
```

### Skip Automatic Setup for Specific Repos

If a repository already has `.devcontainer`, this setup automatically skips to avoid conflicts.

## 🐛 Troubleshooting

### Tools not authenticated?
- Check if secrets are added at github.com/settings/codespaces
- Run `claude login` or `codex login` manually

### MCP server not working?
- Check if the required API key secret is set
- Some servers need additional setup (see their docs)

### Setup not running?
- Ensure dotfiles are enabled in GitHub settings
- Repository must be named exactly `dotfiles`

## 📚 Resources

- [Claude Code Documentation](https://docs.claude.com/claude-code)
- [MCP Protocol Spec](https://modelcontextprotocol.io)
- [GitHub Codespaces Docs](https://docs.github.com/codespaces)

## 📄 License

MIT - Feel free to fork and customize!

## 🤝 Contributing

1. Fork this repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## 💡 Tips

- Each Codespace gets 60 hours free per month
- Stop Codespaces when not in use to save hours
- All configuration persists between sessions
- Works with any repository - public or private

---

**Made with ❤️ for developers who want AI-powered coding everywhere**