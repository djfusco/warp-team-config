#!/bin/bash

# Team Sync Commands - Simple one-word workflow management
set -e

REPO_DIR="$HOME/warp-team-config"
IMPORT_SCRIPT="$REPO_DIR/scripts/import-workflows.sh"
EXPORT_SCRIPT="$REPO_DIR/scripts/export-workflows.sh"
PROFILE_MANAGER="$REPO_DIR/scripts/warp-profile-manager.sh"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

usage() {
    echo -e "${BLUE}🔄 Warp Team Sync Commands${NC}"
    echo ""
    echo "Simple one-word commands for team workflow management:"
    echo ""
    echo -e "${GREEN}Daily Commands:${NC}"
    echo "  sync          Pull team updates and import new workflows"
    echo "  share         Export and push your workflows to the team"
    echo "  update        Same as sync (alternative command)"
    echo ""
    echo -e "${GREEN}Profile Commands:${NC}"
    echo "  team          Switch to team profile"
    echo "  private       Switch to private profile" 
    echo "  status        Show current profile and repo status"
    echo ""
    echo -e "${GREEN}Advanced Commands:${NC}"
    echo "  pull-only     Just pull latest changes (don't import)"
    echo "  import-only   Just import workflows (don't pull)"
    echo "  export-only   Just export workflows (don't push)"
    echo "  push-only     Just push changes (don't export)"
    echo ""
    echo -e "${GREEN}Info Commands:${NC}"
    echo "  log           Show recent team activity"
    echo "  workflows     List all team workflows"
    echo "  contributors  Show who's contributing"
    echo ""
    echo -e "${CYAN}Examples:${NC}"
    echo "  $0 sync       # Morning routine: get latest team workflows"
    echo "  $0 share      # End of day: share your new workflows"  
    echo "  $0 team       # Switch to team mode"
    echo "  $0 status     # Check what's happening"
}

check_setup() {
    if [[ ! -d "$REPO_DIR" ]]; then
        echo -e "${RED}❌ Repository not found at $REPO_DIR${NC}"
        echo -e "${YELLOW}💡 Run the setup first: git clone https://github.com/djfusco/warp-team-config.git ~/warp-team-config${NC}"
        exit 1
    fi
    
    if [[ ! -x "$PROFILE_MANAGER" ]]; then
        echo -e "${RED}❌ Profile manager not found or not executable${NC}"
        echo -e "${YELLOW}💡 Run: chmod +x ~/warp-team-config/scripts/*.sh${NC}"
        exit 1
    fi
}

sync_team_workflows() {
    echo -e "${BLUE}🔄 Syncing with team workflows...${NC}"
    
    cd "$REPO_DIR"
    
    # Check if there are uncommitted changes
    if ! git diff-index --quiet HEAD --; then
        echo -e "${YELLOW}⚠️  You have uncommitted changes. Stashing them temporarily...${NC}"
        git stash push -m "Auto-stash before team sync $(date)"
    fi
    
    # Pull latest changes
    echo -e "${CYAN}📥 Pulling latest team updates...${NC}"
    if git pull; then
        echo -e "${GREEN}✅ Successfully pulled latest changes${NC}"
    else
        echo -e "${RED}❌ Failed to pull changes. Check your connection and try again.${NC}"
        exit 1
    fi
    
    # Show what's new
    echo -e "${CYAN}📋 Recent team activity:${NC}"
    git log --oneline -5 --color=always
    echo ""
    
    # Switch to team profile and import
    echo -e "${CYAN}🔧 Switching to team profile...${NC}"
    "$PROFILE_MANAGER" load team
    
    echo -e "${CYAN}📥 Importing new workflows...${NC}"
    if "$IMPORT_SCRIPT"; then
        echo -e "${GREEN}✅ Team sync complete!${NC}"
        echo -e "${YELLOW}⚠️  Please restart Warp to see new workflows${NC}"
    else
        echo -e "${YELLOW}⚠️  Some workflows might not have imported correctly${NC}"
    fi
}

share_workflows() {
    echo -e "${BLUE}📤 Sharing your workflows with the team...${NC}"
    
    # Make sure we're in team profile
    echo -e "${CYAN}🔧 Switching to team profile...${NC}"
    "$PROFILE_MANAGER" load team
    
    cd "$REPO_DIR"
    
    # Export current workflows
    echo -e "${CYAN}📤 Exporting workflows...${NC}"
    "$EXPORT_SCRIPT"
    
    # Check if there are new workflows to share
    if git diff --quiet && git diff --cached --quiet; then
        echo -e "${YELLOW}💡 No new workflows to share${NC}"
        return 0
    fi
    
    # Show what will be shared
    echo -e "${CYAN}📋 Changes to be shared:${NC}"
    git status --porcelain | grep workflows/
    echo ""
    
    # Commit changes
    echo -e "${CYAN}💾 Committing workflows...${NC}"
    git add workflows/
    
    # Interactive commit message
    echo -e "${YELLOW}📝 Describe what you're sharing (press Enter for default):${NC}"
    read -p "Commit message: " commit_message
    
    if [[ -z "$commit_message" ]]; then
        commit_message="Share workflows: $(date '+%Y-%m-%d %H:%M')"
    fi
    
    git commit -m "$commit_message"
    
    # Push to remote
    echo -e "${CYAN}🚀 Pushing to team repository...${NC}"
    if git push; then
        echo -e "${GREEN}✅ Successfully shared your workflows with the team!${NC}"
        echo -e "${CYAN}💡 Team members can run 'sync' to get your updates${NC}"
    else
        echo -e "${RED}❌ Failed to push. Check your connection and try again.${NC}"
        exit 1
    fi
}

show_status() {
    echo -e "${BLUE}📊 Warp Team Status${NC}"
    echo ""
    
    # Current profile
    echo -e "${CYAN}Current Profile:${NC}"
    "$PROFILE_MANAGER" current
    echo ""
    
    # Repository status
    echo -e "${CYAN}Repository Status:${NC}"
    cd "$REPO_DIR"
    
    # Check for uncommitted changes
    if ! git diff-index --quiet HEAD --; then
        echo -e "${YELLOW}⚠️  You have uncommitted changes${NC}"
        git status --porcelain | head -5
    else
        echo -e "${GREEN}✅ Repository is clean${NC}"
    fi
    
    # Check if behind remote
    git fetch --quiet
    local_commit=$(git rev-parse HEAD)
    remote_commit=$(git rev-parse @{u} 2>/dev/null || echo "no-remote")
    
    if [[ "$local_commit" != "$remote_commit" ]] && [[ "$remote_commit" != "no-remote" ]]; then
        echo -e "${YELLOW}⚠️  You're behind the remote. Run 'sync' to update.${NC}"
    else
        echo -e "${GREEN}✅ Up to date with remote${NC}"
    fi
    
    echo ""
    echo -e "${CYAN}Team Workflows:${NC} $(ls workflows/ 2>/dev/null | wc -l || echo 0)"
    echo -e "${CYAN}Last Activity:${NC}"
    git log -1 --pretty=format:"%an - %ar - %s" 2>/dev/null || echo "No commits yet"
}

show_log() {
    echo -e "${BLUE}📋 Recent Team Activity${NC}"
    echo ""
    cd "$REPO_DIR"
    git log --oneline --color=always -10
}

list_workflows() {
    echo -e "${BLUE}💼 Team Workflows${NC}"
    echo ""
    cd "$REPO_DIR"
    if [[ -d "workflows" ]] && [[ "$(ls -A workflows/ 2>/dev/null)" ]]; then
        for workflow in workflows/*.json; do
            if [[ -f "$workflow" ]]; then
                name=$(jq -r '.name // "Unnamed"' "$workflow" 2>/dev/null || echo "Invalid JSON")
                description=$(jq -r '.description // ""' "$workflow" 2>/dev/null | head -c 60)
                echo -e "${GREEN}• ${name}${NC}"
                if [[ -n "$description" && "$description" != "null" ]]; then
                    echo -e "  ${CYAN}${description}...${NC}"
                fi
            fi
        done
    else
        echo -e "${YELLOW}No workflows found${NC}"
    fi
}

show_contributors() {
    echo -e "${BLUE}👥 Team Contributors${NC}"
    echo ""
    cd "$REPO_DIR"
    git shortlog -sn --since="3 months ago" | head -10
}

# Check setup before running commands
check_setup

# Parse command
case "${1:-help}" in
    "sync"|"update")
        sync_team_workflows
        ;;
    "share")
        share_workflows
        ;;
    "team")
        "$PROFILE_MANAGER" load team
        ;;
    "private")
        "$PROFILE_MANAGER" load private
        ;;
    "status")
        show_status
        ;;
    "pull-only")
        cd "$REPO_DIR" && git pull
        ;;
    "import-only")
        "$PROFILE_MANAGER" load team && "$IMPORT_SCRIPT"
        ;;
    "export-only")
        "$PROFILE_MANAGER" load team && "$EXPORT_SCRIPT"
        ;;
    "push-only")
        cd "$REPO_DIR" && git push
        ;;
    "log")
        show_log
        ;;
    "workflows")
        list_workflows
        ;;
    "contributors")
        show_contributors
        ;;
    "help"|"-h"|"--help")
        usage
        ;;
    *)
        echo -e "${RED}❌ Unknown command: $1${NC}"
        echo ""
        usage
        exit 1
        ;;
esac