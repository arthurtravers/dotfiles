# 🚀 AI-Powered Coding from Any Device

**Code with AI assistants from your iPhone, iPad, or any browser - no laptop needed!**

## 🌟 What is this?

This setup gives you **two AI coding assistants** (Claude & Codex) that work directly in your browser - even on your phone! Write code, fix bugs, and build apps from anywhere with an internet connection. No expensive computer required.

### 📱 Works Everywhere
- ✅ **iPhone/Android** - Code from your phone
- ✅ **iPad/Tablet** - Full development on your tablet
- ✅ **Any Browser** - Chrome, Safari, Firefox, Edge
- ✅ **Any Device** - Chromebook, old laptop, work computer
- ✅ **Anywhere** - Coffee shop, beach, airplane (with wifi)

### 🎯 Perfect For
- **Students** - No need for expensive laptops
- **Travelers** - Code from anywhere in the world
- **Beginners** - AI helps you learn as you code
- **Professionals** - Emergency fixes from your phone
- **Anyone** - Who wants AI to write code for them

## ⚡ Quick Start (5 minutes)

### Super Simple Setup:
1. **Fork this repo** - Click the "Fork" button above
2. **Name it** `dotfiles` (must be exactly this)
3. **Enable in GitHub**:
   - Go to [github.com/settings/codespaces](https://github.com/settings/codespaces)
   - Check ✅ "Automatically install dotfiles"
   - Select your `dotfiles` repo
4. **Create a Codespace** on any project:
   - Open any GitHub repo
   - Click green "Code" button
   - Click "Create codespace"
5. **Start coding with AI**:
   ```bash
   claude   # For Claude AI assistant
   codex    # For OpenAI Codex
   ```

That's it! Your AI coding assistants are ready! 🎉

## 🤖 What You Get

### AI Assistants (2 Ways to Use!)

#### 🖥️ Terminal (CLI)
- **Claude Code** (`claude`) - Explains code, writes features, fixes bugs
- **Codex** (`codex`) - Generates functions, converts comments to code

#### 🎨 VSCode Extensions (GUI)
- **Claude for VS Code** - Chat with Claude in the sidebar

### 🔧 15+ Power Tools
Database connections, web deployment, browser automation, and more via MCP servers

## 💡 Why This Matters

### Traditional Coding
- ❌ Need expensive computer ($1000+)
- ❌ Install complex software
- ❌ Stuck at your desk
- ❌ Hours of setup
- ❌ Write everything yourself

### With This Setup
- ✅ Use any device with internet
- ✅ Nothing to install locally
- ✅ Code from anywhere
- ✅ Ready in 5 minutes
- ✅ AI writes code for you

## 🎬 Real Use Cases

- **"Fixed a bug from my iPhone while on the train"**
- **"Built my startup MVP from a $200 Chromebook"**
- **"Kids learning to code on the family iPad"**
- **"Emergency deploy from vacation using hotel WiFi"**

---

# 📖 Full Documentation

## Automatic Codespace Configuration

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

#### Command Line Tools
- **Claude Code CLI**: Anthropic's AI assistant in your terminal
- **Codex CLI**: OpenAI's code completion in terminal

#### VSCode Extensions (Auto-Installed!)
- **Claude for VS Code**: Chat with Claude in the sidebar
- **Playwright Test**: Run and debug E2E tests
- **API Testing Tools**: Thunder Client and REST Client
- **Docker & Dev Containers**: Container management
- **Code Quality**: Prettier, SonarLint, Error Lens

### MCP Servers Included

#### Core Tools
- **[Memory](https://github.com/modelcontextprotocol/servers/tree/main/src/memory)** - Long-term memory storage for context
- **[Sequential Thinking](https://github.com/modelcontextprotocol/servers/tree/main/src/sequential-thinking)** - Chain of thought reasoning
- **[Filesystem](https://github.com/modelcontextprotocol/servers/tree/main/src/filesystem)** - File system operations
- **[Fetch](https://github.com/ModelContextProtocol/servers/tree/main/src/fetch)** - Web fetching capabilities

#### Cloud Services
- **[Supabase](https://github.com/supabase/mcp-server-supabase)** - Database and authentication
- **[Netlify](https://github.com/netlify/mcp-server-netlify)** - Deployment and hosting
- **[Vercel](https://github.com/vercel/mcp)** - Deployment platform integration
- **[Sentry](https://github.com/sentry/mcp-server-sentry)** - Error tracking and monitoring

#### Search & Data
- **[Brave Search](https://github.com/modelcontextprotocol/servers/tree/main/src/brave-search)** - Web search capabilities
- **[Context7](https://github.com/Upstash/context7-mcp)** - Documentation retrieval

#### Automation & Development
- **[Playwright](https://github.com/Playwright/mcp-server-playwright)** - Browser automation (headless Chrome)
- **[GitHub](https://github.com/modelcontextprotocol/servers/tree/main/src/github)** - GitHub API integration
- **[Hugging Face](https://github.com/cloudflare/hf-mcp-server)** - ML model hub access
- **[Analytics](https://github.com/hannesrudolph/analytics-mcp)** - Google Analytics integration
- **[Everything](https://github.com/modelcontextprotocol/servers/tree/main/src/everything)** - Testing server for MCP features

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

> 💡 **How to get Claude tokens**: Run `claude login` locally, then check `~/.claude.json` for these values

#### Codex Authentication (Auto-login)
- `CODEX_ID_TOKEN` - Your Codex ID token
- `CODEX_ACCESS_TOKEN` - Your Codex access token
- `CODEX_REFRESH_TOKEN` - Your Codex refresh token
- `CODEX_ACCOUNT_ID` - Your Codex account ID

> 💡 **How to get Codex tokens**: Run `codex login` locally, then check `~/.codex/auth.json` for these values

#### VSCode Extension API Keys (Optional)
- `ANTHROPIC_API_KEY` - For Claude VS Code extension (if not using OAuth)

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

Once your Codespace is ready, you have **TWO ways** to use AI:

### Option 1: Terminal (CLI)
```bash
# Use Claude Code
claude

# Use Codex
codex

# Both are pre-authenticated if you added secrets!
```

### Option 2: VSCode Extensions (GUI)
1. Look for the **Claude icon** in the sidebar (auto-installed)
2. Access via Command Palette (`Cmd/Ctrl + Shift + P`)
3. Extensions load automatically in background

### 💡 Pro Tip
- Use **extensions** for visual, interactive chat
- Use **CLI** for quick terminal commands and automation
- Both work simultaneously!

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

### Documentation
- [Claude Code Documentation](https://docs.claude.com/claude-code)
- [MCP Protocol Spec](https://modelcontextprotocol.io)
- [GitHub Codespaces Docs](https://docs.github.com/codespaces)
- [GitHub Dotfiles Guide](https://docs.github.com/en/codespaces/customizing-your-codespace/personalizing-github-codespaces-for-your-account#dotfiles)

### MCP Server Repositories
- [Official MCP Servers Collection](https://github.com/modelcontextprotocol/servers)
- [Awesome MCP Servers](https://github.com/punkpeye/awesome-mcp-servers) - Community curated list
- [MCP Hub](https://hub.mcp.io) - Discover more MCP servers

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