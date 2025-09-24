# Warp Team Configuration Sharing

This repository provides a system for sharing Warp terminal configurations, workflows, and "training" between team members while maintaining personal customizations.

## 🎯 Overview

- **Team Repository**: Shared workflows, project rules, and configurations
- **Personal Profiles**: Switch between private and team configurations
- **Easy Sync**: Scripts to import/export and sync configurations
- **Version Control**: All configurations are stored in JSON and tracked in Git

## 🚀 Quick Start

### 1. Setup (For Each Team Member)

```bash
# Clone the team repository
git clone https://github.com/djfusco/warp-team-config.git ~/warp-team-config
cd ~/warp-team-config

# Create default profiles (private and team)
./scripts/warp-profile-manager.sh create-defaults

# Add aliases to your shell profile
echo 'source ~/warp-team-config/scripts/warp-aliases.sh' >> ~/.zshrc
source ~/.zshrc
```

### 2. Daily Usage

```bash
# Switch to team configuration
warp-team

# Switch to private configuration  
warp-private

# Check current profile
warp-current

# List all profiles
warp-list

# See detailed status
warp-status
```

## 🔧 Profile Management

### Switching Between Configurations

The profile manager allows you to easily switch between different Warp configurations:

```bash
# Using the full command
~/warp-team-config/scripts/warp-profile-manager.sh load team

# Using aliases (after sourcing warp-aliases.sh)
warp-team          # Switch to team profile
warp-private       # Switch to personal profile
wp load custom     # Load any custom profile
```

### Creating New Profiles

```bash
# Save current configuration as a new profile
warp-profile save my-custom-profile

# Create specialized profiles for different projects
warp-profile save project-frontend
warp-profile save project-backend
```

### Managing Profiles

```bash
# List all profiles
warp-profile list

# Delete a profile
warp-profile delete old-profile

# Show current active profile
warp-profile current
```

## 📁 Repository Structure

```
warp-team-config/
├── workflows/              # Shared Warp workflows (JSON files)
├── project-rules/          # Project-specific rules
├── aliases/               # Shell aliases and functions
├── scripts/               # Management and sync scripts
│   ├── warp-profile-manager.sh    # Main profile switching tool
│   ├── import-workflows.sh        # Import workflows into Warp
│   ├── export-workflows.sh        # Export workflows from Warp
│   └── warp-aliases.sh            # Shell aliases for convenience
└── docs/                  # Documentation and examples
```

## 🔄 Team Workflow

### Contributing New Workflows

1. **Create the workflow in Warp** (via Warp Drive or command saving)
2. **Export it to the repository**:
   ```bash
   cd ~/warp-team-config
   ./scripts/export-workflows.sh
   ```
3. **Review and commit**:
   ```bash
   git add workflows/
   git commit -m "Add new workflow: <workflow-name>"
   git push
   ```

### Syncing Team Updates

```bash
# Pull latest team configurations
cd ~/warp-team-config
git pull

# Import new workflows (while in team profile)
warp-team  # Switch to team profile
./scripts/import-workflows.sh

# Restart Warp to see changes
```

### Sharing Your Training/Knowledge

1. **Document your workflows**: Add descriptions to workflow JSON files
2. **Export specialized configurations**: Create profiles for specific use cases
3. **Share examples**: Add example commands and usage patterns to `docs/`
4. **Create project rules**: Set up project-specific configurations

## 🛠️ Advanced Usage

### Custom Profile Creation

```bash
# Start with team base
warp-team

# Make your customizations in Warp
# Add workflows, change settings, etc.

# Save as new profile
warp-profile save my-specialized-setup
```

### Selective Workflow Sharing

You can choose which workflows to include in team vs personal profiles:

1. **Export all workflows**: `./scripts/export-workflows.sh`
2. **Review the JSON files** in `workflows/`
3. **Remove personal/sensitive workflows** before committing
4. **Keep team-relevant workflows** for sharing

### Backup and Recovery

The profile manager automatically creates backups before any changes:

```bash
# Backups are stored alongside the main database
ls -la ~/Library/Application\ Support/dev.warp.Warp-Stable/warp.sqlite.backup.*

# Restore from backup if needed
cp ~/Library/Application\ Support/dev.warp.Warp-Stable/warp.sqlite.backup.TIMESTAMP \
   ~/Library/Application\ Support/dev.warp.Warp-Stable/warp.sqlite
```

## 🔐 Privacy & Security

- **Personal profile**: Keeps your private workflows, history, and settings
- **Team profile**: Only contains shared/approved team configurations  
- **Automatic backups**: All changes create timestamped backups
- **Git ignored sensitive data**: Add patterns to `.gitignore` for sensitive files

## 🐛 Troubleshooting

### Profile not switching?
- Restart Warp after switching profiles
- Check that the profile exists: `warp-profile list`
- Verify Warp database location

### Import/export not working?
- Ensure SQLite3 is installed: `sqlite3 --version`
- Check Warp database permissions
- Verify JSON syntax in workflow files

### Missing aliases?
- Source the aliases file: `source ~/warp-team-config/scripts/warp-aliases.sh`
- Add to your shell profile permanently
- Check file permissions: `chmod +x scripts/*.sh`

## 📋 Commands Reference

### Profile Management
```bash
warp-profile list                    # List all profiles
warp-profile current                 # Show current profile
warp-profile save <name>             # Save current config as profile
warp-profile load <name>             # Load a profile
warp-profile delete <name>           # Delete a profile
warp-profile create-defaults         # Create private/team profiles
```

### Quick Aliases
```bash
wp                                   # Short for warp-profile
warp-team                           # Switch to team profile
warp-private                        # Switch to private profile
warp-current                        # Show current profile
warp-list                           # List profiles
warp-status                         # Detailed status
warp-switch <name>                  # Switch with confirmation
```

### Sync Scripts
```bash
./scripts/export-workflows.sh       # Export workflows to repository
./scripts/import-workflows.sh       # Import workflows from repository
```

## 🤝 Team Setup Example

1. **Team lead** sets up the repository:
   - Fork or clone this repository on GitHub
   - Customize for your team's needs
   - Share the repository URL with team members

2. **Each team member** clones and sets up:
   ```bash
git clone https://github.com/djfusco/warp-team-config.git ~/warp-team-config
   cd ~/warp-team-config
   ./scripts/warp-profile-manager.sh create-defaults
   echo 'source ~/warp-team-config/scripts/warp-aliases.sh' >> ~/.zshrc
   ```

3. **Regular workflow**:
   - Work in personal profile for individual tasks
   - Switch to team profile for collaborative work
   - Export and share useful workflows
   - Pull updates regularly

This system gives you the flexibility to maintain your personal Warp setup while easily accessing and contributing to team knowledge!