# 🔄 Complete Team Workflow Guide

This guide explains how team members share workflows and how everyone stays in sync.

## 📤 How Team Members Share Their Personal Workflows

### **Step 1: Team Member Creates/Has Useful Workflow**
```bash
# Team member working in their private profile
warp-private

# They've created some useful workflows in Warp
# (via Warp Drive, command saving, etc.)
```

### **Step 2: Switch to Team Profile and Import**
```bash
# Switch to team profile
warp-team

# Export their current workflows from private profile first
# (This captures both team and personal workflows)
cd ~/warp-team-config
./scripts/export-workflows.sh

# Review what got exported
ls -la workflows/
```

### **Step 3: Selective Sharing (Optional)**
```bash
# If they want to share only specific workflows:

# 1. Go back to private profile
warp-private

# 2. Remove workflows they don't want to share from Warp
# (temporarily, in the UI)

# 3. Export only the ones they want to share
warp-team  # Switch to clean team profile
./scripts/export-workflows.sh

# 4. This exports only the workflows they want to share
```

### **Step 4: Commit and Push to Share**
```bash
# Review the exported workflows
git status
git diff

# Commit the new workflows
git add workflows/
git commit -m "Add workflow: automated database backup

- Backs up production database to S3
- Includes compression and encryption
- Useful for daily maintenance tasks"

# Push to share with team
git push
```

## 📥 How You (and Others) Get New Team Workflows

### **Step 1: Pull Latest Changes**
```bash
cd ~/warp-team-config
git pull origin main
```

### **Step 2: Review What's New**
```bash
# See what workflows were added
git log --oneline -5

# Check new workflow files
ls -la workflows/

# Preview a new workflow
jq . workflows/new-workflow-name.json
```

### **Step 3: Import New Workflows**
```bash
# Switch to team profile
warp-team

# Import all new workflows
./scripts/import-workflows.sh

# Restart Warp to see new workflows in the UI
```

## 🔄 Complete Daily Team Workflow

### **Morning Routine (Stay Updated)**
```bash
# Check for team updates
cd ~/warp-team-config
git pull

# Switch to team mode
warp-team

# Import any new workflows
./scripts/import-workflows.sh

# Quick restart of Warp to see updates
# (Close and reopen Warp)
```

### **During Work (Use Team Workflows)**
```bash
# Working in team mode
warp-team

# All team workflows are available
# Use shared knowledge and workflows
```

### **Personal Work**
```bash
# Switch to personal setup when needed
warp-private

# Your personal workflows and settings
# Experiment, create new workflows
```

### **End of Day (Share Useful Work)**
```bash
# If you created something useful today:
warp-team

# Export and share
cd ~/warp-team-config
./scripts/export-workflows.sh

# Review and commit
git add workflows/
git commit -m "Add workflow: [description]"
git push
```

## 🎯 Workflow Management Strategies

### **Strategy 1: Individual Contribution**
Each team member contributes workflows independently:

```bash
# Team member A adds deployment workflows
git commit -m "Add deployment workflows for staging/prod"

# Team member B adds testing workflows  
git commit -m "Add automated testing workflows"

# Team member C adds database workflows
git commit -m "Add database maintenance workflows"
```

### **Strategy 2: Curated Team Workflows**
Team lead curates which workflows go to the team:

```bash
# Team members create PRs instead of direct pushes
git checkout -b add-monitoring-workflows
git add workflows/monitoring-*.json
git commit -m "Propose monitoring workflows"
git push origin add-monitoring-workflows

# Create PR on GitHub for review
# Team lead reviews and merges
```

### **Strategy 3: Domain-Specific Profiles**
Create specialized team profiles:

```bash
# Create different team profiles
warp-profile save team-frontend    # Frontend-specific workflows
warp-profile save team-backend     # Backend-specific workflows  
warp-profile save team-devops      # DevOps-specific workflows

# Team members can contribute to specific domains
```

## 🔍 Advanced Workflow Management

### **Selective Workflow Import**
```bash
# Don't import all workflows - be selective
cd ~/warp-team-config

# Review new workflows first
ls workflows/ | grep -E "(new|added|recent)"

# Import specific workflows only
# (Edit the import script or manually copy JSON to Warp)
```

### **Workflow Versioning**
```bash
# Version your workflows with meaningful commits
git commit -m "Update deployment workflow v2.1

- Add rollback capability
- Improve error handling  
- Add progress indicators"

# Tag important versions
git tag -a v1.0 -m "Stable team workflow set v1.0"
```

### **Conflict Resolution**
```bash
# If multiple people modify the same workflow
git pull  # Might have merge conflicts

# Review conflicts in workflow JSON files
git status
git diff

# Resolve conflicts (keep best version or merge features)
# Then commit resolution
git commit -m "Merge workflow improvements from team"
```

## 🚀 Pro Team Workflow Tips

### **1. Workflow Naming Convention**
```json
{
  "name": "[CATEGORY] Descriptive name",
  "description": "What it does and when to use it"
}

// Examples:
// "[GIT] Interactive rebase with conflict resolution"  
// "[DOCKER] Clean system and rebuild dev environment"
// "[DB] Backup production with encryption"
```

### **2. Regular Team Sync**
```bash
# Weekly team workflow sync
cd ~/warp-team-config

# Everyone pulls latest
git pull

# Import all new workflows
warp-team
./scripts/import-workflows.sh

# Team discusses new workflows in standup/meeting
```

### **3. Workflow Documentation**
```bash
# Document complex workflows in the repository
echo "# Database Backup Workflow

## Usage
- Run daily at 2 AM
- Requires S3 credentials
- Backs up to encrypted bucket

## Dependencies  
- aws-cli configured
- gpg for encryption" > docs/database-backup-workflow.md

git add docs/database-backup-workflow.md
git commit -m "Document database backup workflow"
```

### **4. Testing New Workflows**
```bash
# Always test in private first
warp-private

# Create and test new workflow
# Once confirmed working:

warp-team
# Recreate the tested workflow
./scripts/export-workflows.sh
git add workflows/
git commit -m "Add tested workflow: [name]"
```

## 🎭 Example: Complete Workflow Sharing Session

Here's a complete example of a team member sharing a workflow:

### **Sarah creates useful deployment workflow**
```bash
# Sarah working in private
warp-private

# She creates "Deploy with health check" workflow in Warp
# Tests it, works great!

# She wants to share it with team
warp-team

# Switch to team profile, create the workflow again
# (Or copy the JSON from private export to team)

# Export the new workflow
cd ~/warp-team-config
./scripts/export-workflows.sh

# Check what's new
git status
# workflows/deploy-with-health-check.json

# Review the workflow
jq . workflows/deploy-with-health-check.json

# Commit and share
git add workflows/deploy-with-health-check.json
git commit -m "Add deployment workflow with health checks

- Deploys to staging first
- Runs health checks before promoting to prod
- Includes rollback on failure
- Useful for safe production deployments"

git push
```

### **You (and others) get Sarah's workflow**
```bash
# Next day, you start work
cd ~/warp-team-config
git pull

# See Sarah's new workflow
git log --oneline -3
# "Add deployment workflow with health checks"

# Import it
warp-team
./scripts/import-workflows.sh

# Restart Warp - now you have Sarah's deployment workflow!
# It appears in your Warp Drive under team workflows
```

This creates a continuous cycle of sharing and improving team knowledge! 🔄

## 📊 Monitoring Team Workflow Health

```bash
# Check team activity
cd ~/warp-team-config
git log --pretty=format:"%an %ad %s" --date=short | head -10

# See workflow growth
echo "Total team workflows: $(ls workflows/ | wc -l)"

# Check who's contributing
git shortlog -sn --since="1 month ago"
```

This system turns your team's individual Warp expertise into shared organizational knowledge!