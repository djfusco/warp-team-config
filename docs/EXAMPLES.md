# 📚 Examples & Use Cases

This document provides practical examples of how to use the Warp team configuration system effectively.

## 🎯 Common Workflows

### Daily Development Routine

```bash
# Morning: Start with team configuration
cd ~/my-project
warp-team

# Work collaboratively using shared workflows
# (All team workflows are available)

# Afternoon: Switch to personal setup for focused work
warp-private

# Use your personal shortcuts and configurations

# Evening: Share something useful you created
warp-team
# Create a workflow in Warp, then:
cd ~/warp-team-config
./scripts/export-workflows.sh
git add workflows/new-useful-workflow.json
git commit -m "Add workflow for database migration"
git push
```

### Project-Specific Setup

```bash
# Create specialized profiles for different projects
warp-team  # Start with team base
# Set up project-specific workflows in Warp
warp-profile save client-alpha-frontend

warp-team  # Reset to team base  
# Configure for different project
warp-profile save client-beta-backend

# Switch between project contexts
warp-profile load client-alpha-frontend
warp-profile load client-beta-backend
```

### Onboarding New Team Member

```bash
# New team member runs:
git clone https://github.com/djfusco/warp-team-config.git ~/warp-team-config
cd ~/warp-team-config
./scripts/warp-profile-manager.sh create-defaults
echo 'source ~/warp-team-config/scripts/warp-aliases.sh' >> ~/.zshrc
source ~/.zshrc

# Test the setup
warp-current    # Should show: private
warp-team      # Switch to team config
warp-list      # Should show: private, team

# They immediately have access to all team workflows!
```

## 🛠️ Advanced Use Cases

### Custom Workflow Development

```bash
# Develop a new workflow in your private environment
warp-private

# Create and test the workflow in Warp
# Once it's working well...

# Share it with the team
warp-team
# Recreate the workflow in team environment
# Or copy specific workflow JSON files

cd ~/warp-team-config
./scripts/export-workflows.sh

# Review the exported workflow
jq . workflows/my-new-workflow.json

# Commit and share
git add workflows/my-new-workflow.json
git commit -m "Add workflow: automated testing pipeline"
git push
```

### Team Sync and Updates

```bash
# Weekly team sync routine
cd ~/warp-team-config
git pull origin main

# Check what's new
git log --oneline -10
ls -la workflows/

# Import new workflows
warp-team
./scripts/import-workflows.sh

# Restart Warp to see new workflows
```

### Backup and Migration

```bash
# Before major changes, backup everything
cd ~/warp-team-config
./scripts/export-workflows.sh
git add .
git commit -m "Backup before major changes"

# Create a snapshot profile
warp-profile save backup-$(date +%Y%m%d)

# Now safe to experiment
```

### Multi-Client Workflow

```bash
# Setup for consultants working with multiple clients
warp-profile save client-a-config
warp-profile save client-b-config
warp-profile save personal-projects

# Quick switching between contexts
alias client-a='warp-profile load client-a-config'
alias client-b='warp-profile load client-b-config' 
alias personal='warp-profile load personal-projects'
```

## 📋 Example Workflows to Create

Here are some useful workflows your team might want to create:

### Git Workflows
```json
{
  "name": "Interactive rebase last N commits",
  "command": "git rebase -i HEAD~{{num_commits}}",
  "description": "Interactively rebase the last N commits",
  "arguments": [
    {
      "name": "num_commits",
      "arg_type": "Text",
      "description": "Number of commits to rebase",
      "default_value": "3"
    }
  ]
}
```

### Docker Workflows
```json
{
  "name": "Clean Docker system",
  "command": "docker system prune -af && docker volume prune -f",
  "description": "Clean up Docker containers, images, and volumes"
}
```

### Project Setup Workflows
```json
{
  "name": "Setup Node.js project",
  "command": "npm init -y && npm install --save-dev eslint prettier && echo 'node_modules/' > .gitignore",
  "description": "Initialize a new Node.js project with common tools"
}
```

## 🔧 Customization Examples

### Custom Aliases
Add to `scripts/warp-aliases.sh`:
```bash
# Custom team aliases
alias deploy-staging='warp-profile load staging-deploy'
alias deploy-prod='warp-profile load production-deploy'
alias quick-switch='warp-profile load'

# Project shortcuts  
alias frontend='cd ~/projects/frontend && warp-profile load frontend-dev'
alias backend='cd ~/projects/backend && warp-profile load backend-dev'
```

### Environment-Specific Profiles
```bash
# Development environment
warp-profile save dev-environment
# - Development database connections
# - Local service URLs  
# - Debug-friendly workflows

# Staging environment
warp-profile save staging-environment
# - Staging database connections
# - Staging service URLs
# - Deployment workflows

# Production environment  
warp-profile save prod-environment
# - Production-safe commands only
# - Careful deployment workflows
# - Monitoring and logging tools
```

## 🎨 Team Organization Strategies

### By Role
```bash
# Frontend developers
warp-profile save frontend-base
# - React/Vue workflows
# - CSS/styling tools
# - Browser testing commands

# Backend developers  
warp-profile save backend-base
# - API testing workflows
# - Database management
# - Server deployment tools

# DevOps engineers
warp-profile save devops-base
# - Infrastructure commands
# - Monitoring workflows  
# - CI/CD pipelines
```

### By Project Phase
```bash
# Discovery/Planning
warp-profile save discovery-phase
# - Research workflows
# - Documentation tools
# - Analysis commands

# Development
warp-profile save development-phase  
# - Coding workflows
# - Testing tools
# - Debug commands

# Deployment
warp-profile save deployment-phase
# - Build pipelines
# - Release workflows
# - Production tools
```

## 📊 Monitoring and Maintenance

### Regular Maintenance
```bash
# Weekly cleanup routine
cd ~/warp-team-config

# Check for outdated workflows
ls -la workflows/ | head -20

# Update repository
git pull
git status

# Clean up old profiles
warp-profile list
warp-profile delete old-experimental-profile

# Backup current state
warp-profile save weekly-backup-$(date +%Y%m%d)
```

### Team Health Checks
```bash
# Check team adoption
cd ~/warp-team-config
git log --pretty=format:"%an %ad %s" --date=short | head -20

# Analyze workflow usage
grep -r "name" workflows/ | wc -l
echo "Total team workflows: $(ls workflows/ | wc -l)"

# Profile status across team
warp-status
```

## 🚨 Recovery Scenarios

### Lost Profiles
```bash
# If ~/.warp-profiles gets deleted
cd ~/warp-team-config
./scripts/warp-profile-manager.sh create-defaults

# Restore from backup if needed
ls -la ~/Library/Application\ Support/dev.warp.Warp-Stable/warp.sqlite.backup.*
cp ~/Library/Application\ Support/dev.warp.Warp-Stable/warp.sqlite.backup.LATEST \
   ~/Library/Application\ Support/dev.warp.Warp-Stable/warp.sqlite
```

### Repository Issues
```bash
# If repository gets corrupted
cd ~
mv warp-team-config warp-team-config.broken
git clone https://github.com/djfusco/warp-team-config.git ~/warp-team-config

# Re-run setup
cd ~/warp-team-config  
./scripts/warp-profile-manager.sh create-defaults
```

### Profile Corruption
```bash
# If a profile becomes corrupted
warp-profile delete corrupted-profile
warp-profile save new-clean-profile

# Restore from Warp database backup
ls -la ~/Library/Application\ Support/dev.warp.Warp-Stable/warp.sqlite.backup.*
# Choose appropriate backup and restore
```

These examples should help your team get the most out of the Warp configuration sharing system!