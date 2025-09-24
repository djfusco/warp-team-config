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
warp-team         # Switch to team configuration  
warp-private      # Switch back to personal setup
warp-current      # Check which profile is active
warp-status       # See detailed status
```

## Share New Workflows

```bash
# After creating a workflow in Warp:
cd ~/warp-team-config
./scripts/export-workflows.sh
git add workflows/
git commit -m "Add workflow: [description]"
git push
```

## Get Team Updates

```bash
cd ~/warp-team-config
git pull
warp-team
./scripts/import-workflows.sh
# Restart Warp
```

---

**Repository**: https://github.com/djfusco/warp-team-config  
**Full Documentation**: See README.md and SETUP.md in the repository