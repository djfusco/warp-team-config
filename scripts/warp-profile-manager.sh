#!/bin/bash

# Warp Profile Manager - Switch between private and team configurations
set -e

WARP_DB="$HOME/Library/Application Support/dev.warp.Warp-Stable/warp.sqlite"
PROFILES_DIR="$HOME/.warp-profiles"
CURRENT_PROFILE_FILE="$PROFILES_DIR/.current-profile"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

usage() {
    echo "🔧 Warp Profile Manager"
    echo ""
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  list                 List all available profiles"
    echo "  current              Show current active profile"
    echo "  save <name>          Save current Warp config as a profile"
    echo "  load <name>          Load a profile"
    echo "  delete <name>        Delete a profile"
    echo "  create-defaults      Create default 'private' and 'team' profiles"
    echo ""
    echo "Examples:"
    echo "  $0 save private      # Save current config as 'private' profile"
    echo "  $0 load team         # Switch to 'team' profile"
    echo "  $0 list              # Show all profiles"
}

init_profiles_dir() {
    mkdir -p "$PROFILES_DIR"
    if [[ ! -f "$CURRENT_PROFILE_FILE" ]]; then
        echo "default" > "$CURRENT_PROFILE_FILE"
    fi
}

backup_current_db() {
    local backup_name="$1"
    cp "$WARP_DB" "$WARP_DB.backup.$backup_name.$(date +%Y%m%d_%H%M%S)"
    echo -e "${GREEN}✅ Created backup: $backup_name${NC}"
}

save_profile() {
    local profile_name="$1"
    if [[ -z "$profile_name" ]]; then
        echo -e "${RED}❌ Profile name required${NC}"
        exit 1
    fi
    
    init_profiles_dir
    backup_current_db "before_save_$profile_name"
    
    cp "$WARP_DB" "$PROFILES_DIR/$profile_name.sqlite"
    echo "$profile_name" > "$CURRENT_PROFILE_FILE"
    
    echo -e "${GREEN}✅ Saved current configuration as profile: $profile_name${NC}"
}

load_profile() {
    local profile_name="$1"
    if [[ -z "$profile_name" ]]; then
        echo -e "${RED}❌ Profile name required${NC}"
        exit 1
    fi
    
    local profile_file="$PROFILES_DIR/$profile_name.sqlite"
    if [[ ! -f "$profile_file" ]]; then
        echo -e "${RED}❌ Profile '$profile_name' not found${NC}"
        list_profiles
        exit 1
    fi
    
    init_profiles_dir
    backup_current_db "before_load_$profile_name"
    
    cp "$profile_file" "$WARP_DB"
    echo "$profile_name" > "$CURRENT_PROFILE_FILE"
    
    echo -e "${GREEN}✅ Loaded profile: $profile_name${NC}"
    echo -e "${YELLOW}⚠️  Please restart Warp to see changes${NC}"
}

list_profiles() {
    echo -e "${BLUE}📋 Available Profiles:${NC}"
    
    if [[ ! -d "$PROFILES_DIR" ]]; then
        echo -e "${YELLOW}  No profiles found. Create one with: $0 save <name>${NC}"
        return
    fi
    
    local current_profile=""
    if [[ -f "$CURRENT_PROFILE_FILE" ]]; then
        current_profile=$(cat "$CURRENT_PROFILE_FILE")
    fi
    
    for profile_file in "$PROFILES_DIR"/*.sqlite; do
        if [[ -f "$profile_file" ]]; then
            local profile_name=$(basename "$profile_file" .sqlite)
            local marker=""
            if [[ "$profile_name" == "$current_profile" ]]; then
                marker=" ${GREEN}(current)${NC}"
            fi
            echo -e "  • $profile_name$marker"
        fi
    done
    
    if [[ -z "$(ls -A "$PROFILES_DIR"/*.sqlite 2>/dev/null)" ]]; then
        echo -e "${YELLOW}  No profiles found. Create one with: $0 save <name>${NC}"
    fi
}

show_current() {
    init_profiles_dir
    local current_profile=$(cat "$CURRENT_PROFILE_FILE" 2>/dev/null || echo "unknown")
    echo -e "${BLUE}Current profile: ${GREEN}$current_profile${NC}"
}

delete_profile() {
    local profile_name="$1"
    if [[ -z "$profile_name" ]]; then
        echo -e "${RED}❌ Profile name required${NC}"
        exit 1
    fi
    
    local profile_file="$PROFILES_DIR/$profile_name.sqlite"
    if [[ ! -f "$profile_file" ]]; then
        echo -e "${RED}❌ Profile '$profile_name' not found${NC}"
        exit 1
    fi
    
    read -p "Are you sure you want to delete profile '$profile_name'? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm "$profile_file"
        echo -e "${GREEN}✅ Deleted profile: $profile_name${NC}"
    else
        echo -e "${YELLOW}❌ Cancelled${NC}"
    fi
}

create_defaults() {
    echo -e "${BLUE}🔧 Creating default profiles...${NC}"
    
    # Save current as private
    save_profile "private"
    
    # Create team profile by importing team workflows
    echo -e "${BLUE}📥 Setting up team profile...${NC}"
    
    # Reset to a clean state for team profile
    sqlite3 "$WARP_DB" "DELETE FROM workflows WHERE json_extract(data, '$.name') NOT IN ('Example workflow');"
    
    # Import team workflows
    local team_repo_dir="$(dirname "$0")/.."
    if [[ -d "$team_repo_dir/workflows" ]]; then
        "$team_repo_dir/scripts/import-workflows.sh" || true
    fi
    
    save_profile "team"
    
    # Switch back to private
    load_profile "private"
    
    echo -e "${GREEN}✅ Created default profiles: 'private' and 'team'${NC}"
    echo -e "${YELLOW}💡 Use '$0 load team' to switch to team configuration${NC}"
}

# Check if Warp DB exists
if [[ ! -f "$WARP_DB" ]]; then
    echo -e "${RED}❌ Warp database not found at: $WARP_DB${NC}"
    echo -e "${YELLOW}💡 Make sure Warp is installed and has been run at least once${NC}"
    exit 1
fi

# Parse command
case "${1:-}" in
    "list"|"ls")
        list_profiles
        ;;
    "current"|"status")
        show_current
        ;;
    "save")
        save_profile "$2"
        ;;
    "load"|"switch")
        load_profile "$2"
        ;;
    "delete"|"rm")
        delete_profile "$2"
        ;;
    "create-defaults")
        create_defaults
        ;;
    "help"|"-h"|"--help")
        usage
        ;;
    "")
        usage
        ;;
    *)
        echo -e "${RED}❌ Unknown command: $1${NC}"
        echo ""
        usage
        exit 1
        ;;
esac