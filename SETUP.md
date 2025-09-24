# 🚀 Warp Team Configuration Setup Guide

Welcome to the team! This guide will help you set up the shared Warp configuration system so you can:

- ✅ Switch between your personal and team Warp configurations
- ✅ Access all shared team workflows and "training"
- ✅ Contribute your own useful workflows back to the team
- ✅ Stay synced with team updates

## ⚡ Quick Setup (5 minutes)

### Prerequisites
- Warp terminal installed and run at least once
- Git configured on your machine
- macOS, Linux, or Windows (with proper shell)

### 1. Clone the Repository
```bash
# Clone to your home directory
git clone https://github.com/YOUR-USERNAME/warp-team-config.git ~/warp-team-config
cd ~/warp-team-config
```

### 2. Initial Setup
```bash
# Create your personal and team profiles
./scripts/warp-profile-manager.sh create-defaults

# Add convenient aliases to your shell
echo 'source ~/warp-team-config/scripts/warp-aliases.sh' >> ~/.zshrc
source ~/.zshrc
```

### 3. Test the Setup
```bash
# Check current profile
warp-current

# List available profiles
warp-list

# Switch to team configuration
warp-team

# Switch back to personal
warp-private
```

**🎉 That's it! You're ready to use the system.**

## 📋 What Just Happened?

### Profiles Created:
- **`private`**: Your current Warp setup (workflows, history, settings)
- **`team`**: Clean base + shared team workflows

### Commands Available:
```bash
warp-team        # Switch to team configuration
warp-private     # Switch to personal configuration
warp-current     # Show active profile
warp-list        # List all profiles
warp-status      # Detailed status view
```

### Files Added:
- `~/.warp-profiles/`: Profile storage (DO NOT delete this!)
- Shell aliases sourced in your `.zshrc`
- Automatic backups of your Warp database

## 🔄 Daily Usage

### Morning Routine
```bash
# Check for team updates
cd ~/warp-team-config
git pull

# Switch to team mode for collaborative work
warp-team

# Import any new workflows
./scripts/import-workflows.sh

# Restart Warp to see changes
```

### Personal Work
```bash
# Switch to your personal setup
warp-private

# Work with your custom workflows and settings
```

### Sharing New Workflows
```bash
# Switch to team profile
warp-team

# Create your workflow in Warp (via Warp Drive or saving commands)

# Export to repository
cd ~/warp-team-config
./scripts/export-workflows.sh

# Review and commit
git add workflows/
git commit -m "Add workflow: [workflow name]"
git push
```

## 🛠️ Advanced Setup Options

### Custom Shell Configuration
If you don't use zsh, add to your shell's config file:
```bash
# For bash users (.bashrc)
echo 'source ~/warp-team-config/scripts/warp-aliases.sh' >> ~/.bashrc

# For fish users (config.fish)
echo 'source ~/warp-team-config/scripts/warp-aliases.sh' >> ~/.config/fish/config.fish
```

### Custom Profile Names
```bash
# Create specialized profiles
warp-profile save frontend-dev
warp-profile save backend-ops
warp-profile save client-work
```

### Selective Workflow Import
```bash
# Review workflows before importing
ls -la ~/warp-team-config/workflows/

# Edit/remove workflows you don't want
# Then import
./scripts/import-workflows.sh
```

## 🔐 Privacy & Security

### What's Shared
- ✅ Approved team workflows
- ✅ Project-specific configurations
- ✅ Common aliases and shortcuts

### What Stays Private
- ❌ Your command history
- ❌ Personal workflows (unless you export them)
- ❌ Sensitive environment variables
- ❌ Private project configurations

### Data Locations
- **Team data**: `~/warp-team-config/` (version controlled)
- **Profile data**: `~/.warp-profiles/` (local only, never shared)
- **Warp database**: `~/Library/Application Support/dev.warp.Warp-Stable/` (backed up automatically)

## 🆘 Troubleshooting

### "Profile manager not found"
```bash
# Check the repository location
ls -la ~/warp-team-config/scripts/warp-profile-manager.sh

# Re-clone if missing
rm -rf ~/warp-team-config
git clone https://github.com/YOUR-USERNAME/warp-team-config.git ~/warp-team-config
```

### "Database not found" 
```bash
# Make sure Warp is installed and has been run
open -a Warp

# Check database location (macOS)
ls -la ~/Library/Application\ Support/dev.warp.Warp-Stable/warp.sqlite
```

### Profile not switching
```bash
# Restart Warp after switching
# Check current profile
warp-current

# Verify profiles exist
warp-list
```

### Import/export errors
```bash
# Check SQLite3 installation
sqlite3 --version

# Check file permissions
chmod +x ~/warp-team-config/scripts/*.sh

# Check JSON syntax
jq . ~/warp-team-config/workflows/some-workflow.json
```

### Lost aliases
```bash
# Re-source the aliases
source ~/warp-team-config/scripts/warp-aliases.sh

# Check if line exists in shell config
grep "warp-aliases.sh" ~/.zshrc
```

## 🤝 Getting Help

### Check Status
```bash
# See detailed system status
warp-status

# Check git status
cd ~/warp-team-config
git status
```

### Reset Everything
```bash
# Nuclear option: start fresh
rm -rf ~/warp-team-config
rm -rf ~/.warp-profiles

# Re-run setup
git clone https://github.com/YOUR-USERNAME/warp-team-config.git ~/warp-team-config
cd ~/warp-team-config
./scripts/warp-profile-manager.sh create-defaults
```

### Contact Team
- 📝 Create an issue in this repository
- 💬 Ask in team chat
- 📧 Contact the repository maintainer

## ✨ Pro Tips

1. **Use descriptive workflow names** when creating team workflows
2. **Test workflows** before sharing them with the team
3. **Pull regularly** to stay updated with team changes
4. **Create project-specific profiles** for different clients/projects
5. **Keep personal workflows in private profile** to avoid accidental sharing

---

**🎯 Ready to be productive? Start with `warp-team` and explore the shared workflows!**