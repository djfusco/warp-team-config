# 🎯 Quick Team Setup Instructions

## For Your Team Members

Send them this **one-command setup**:

```bash
# Complete setup in one command:
git clone https://github.com/djfusco/warp-team-config.git ~/warp-team-config && \
cd ~/warp-team-config && \
./scripts/warp-profile-manager.sh create-defaults && \
echo 'source ~/warp-team-config/scripts/warp-aliases.sh' >> ~/.zshrc && \
source ~/.zshrc && \
echo "✅ Setup complete! Try: warp-team"
```

## What They Get Instantly

✅ **Access to all your team workflows**  
✅ **Easy switching**: `warp-team` / `warp-private`  
✅ **Their personal setup stays private**  
✅ **All your Warp "training" and knowledge**

## Daily Commands

```bash
# Simple one-word commands:
sync              # Morning: get latest team workflows
share             # Evening: share your workflows
team              # Switch to team mode
private           # Switch to personal mode
warp-status       # Check current status
```

## Share New Workflows

```bash
# After creating a workflow in Warp:
share
# That's it! The command handles everything automatically
```

## Get Team Updates

```bash
sync
# That's it! Restart Warp to see new workflows
```

---

**Repository**: https://github.com/djfusco/warp-team-config  
**Full Documentation**: See README.md and SETUP.md in the repository