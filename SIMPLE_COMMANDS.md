# 🎯 Simple One-Word Commands

The easiest way to manage team workflows! After setup, just use these simple commands:

## 🚀 **Daily Commands** (Most Important)

### **Morning - Get Latest Team Workflows**
```bash
sync
```
- Pulls latest team updates
- Switches to team profile  
- Imports new workflows
- Shows what's new

### **Evening - Share Your Workflows**  
```bash
share
```
- Switches to team profile
- Exports your workflows
- Commits and pushes to team
- Asks for description

### **Switch Between Modes**
```bash
team        # Switch to team profile (collaborative work)
private     # Switch to private profile (personal work)
```

## 📊 **Status Commands**

### **Check What's Happening**
```bash
warp-status
```
- Shows current profile
- Repository status
- Whether you're up to date
- Number of team workflows

### **See Team Activity**
```bash
team-log
```
- Recent commits from team
- Who added what workflows
- Last 10 activities

### **List Available Workflows**  
```bash
team-workflows
```
- Shows all team workflows
- Brief descriptions
- Easy to browse

### **See Who's Contributing**
```bash
contributors  
```
- Team member activity
- Contribution stats
- Last 3 months

## 🎪 **Complete Daily Workflow Examples**

### **Start of Day (2 commands)**
```bash
sync        # Get latest team workflows
team        # Switch to team mode for collaborative work
```

### **End of Day (if you created something useful)**
```bash
share       # Share your workflows with team
```

### **Personal Work Time**
```bash
private     # Switch to personal setup for focused work
```

### **Check Status Anytime**
```bash
warp-status # See current state and any updates needed
```

## 🎯 **Real-World Examples**

### **Monday Morning**
```bash
# Get caught up with team over the weekend
sync

# Check what happened
team-log

# Start collaborative work
team
```

### **Found a Useful Workflow**
```bash
# Share it immediately  
share
# > Enter description: "Add database backup with compression"
# > ✅ Successfully shared your workflows with the team!
```

### **Focus Time**
```bash
# Switch to personal setup for deep work
private

# Your personal workflows and settings
# No interruptions from team changes
```

### **Check Team Health**
```bash
# See who's been contributing
contributors

# Browse available workflows
team-workflows

# Check if you need updates
warp-status
```

## 🔧 **Advanced One-Word Commands**

For power users who want more control:

```bash
pull-only      # Just pull changes (don't import)
import-only    # Just import workflows (don't pull)
export-only    # Just export workflows (don't push)
push-only      # Just push changes (don't export)
```

## 💡 **Pro Tips**

### **Morning Routine** (Recommended)
```bash
sync && team-log
```
Get updates and see what's new in one command.

### **Before Big Changes**
```bash
warp-status
```
Make sure you're up to date before making major workflow changes.

### **End of Sprint**
```bash
share && contributors
```
Share your work and celebrate team contributions.

## 🎭 **Complete Example: Sarah's Day**

### **9 AM - Start of Day**
```bash
sync
# 🔄 Syncing with team workflows...
# ✅ Successfully pulled latest changes
# ✅ Team sync complete!

team-log  
# 📋 Recent Team Activity
# b2a1c34 Mike - Add Docker deployment workflow
# a9f3e21 Lisa - Improve database backup with retry logic
```

### **11 AM - Collaborative Work**
```bash
# Already in team mode from sync
# Use Mike's Docker workflow
# Use Lisa's improved backup workflow
```

### **2 PM - Personal Development** 
```bash
private
# Switch to personal setup
# Experiment with new ideas
# Test workflows privately
```

### **5 PM - End of Day**
```bash
team    # Switch back to team
share   # Share today's work
# 📝 Describe what you're sharing: 
# > "Add automated testing workflow with coverage reports"
# ✅ Successfully shared your workflows with the team!
```

## 🚨 **Troubleshooting**

### **Command not found?**
```bash
source ~/.zshrc
# or
source ~/warp-team-config/scripts/warp-aliases.sh
```

### **Repository issues?**
```bash
cd ~/warp-team-config
git status
# Check what's happening
```

### **Sync problems?**  
```bash
warp-status
# Shows detailed status and what might be wrong
```

---

**🎉 That's it! Team workflow management in single words.**

Remember: 
- `sync` in the morning
- `share` when you create something useful  
- `team` for collaborative work
- `private` for personal work