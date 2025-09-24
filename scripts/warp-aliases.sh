#!/bin/bash

# Warp Profile Management Aliases
# Source this file in your shell profile (.zshrc, .bashrc, etc.)

WARP_PROFILE_MANAGER="$HOME/warp-team-config/scripts/warp-profile-manager.sh"
TEAM_SYNC="$HOME/warp-team-config/scripts/team-sync.sh"

# Check if the profile manager exists
if [[ -x "$WARP_PROFILE_MANAGER" ]] && [[ -x "$TEAM_SYNC" ]]; then
    # Main alias
    alias warp-profile="$WARP_PROFILE_MANAGER"
    
    # Convenient shortcuts
    alias wp="$WARP_PROFILE_MANAGER"
    alias warp-private="$WARP_PROFILE_MANAGER load private"
    alias warp-team="$WARP_PROFILE_MANAGER load team"
    alias warp-current="$WARP_PROFILE_MANAGER current"
    alias warp-list="$WARP_PROFILE_MANAGER list"
    
    # Quick status function
    warp-status() {
        echo "🔧 Warp Profile Status:"
        "$WARP_PROFILE_MANAGER" current
        echo ""
        "$WARP_PROFILE_MANAGER" list
    }
    
    # Quick switch function with confirmation
    warp-switch() {
        if [[ -z "$1" ]]; then
            echo "Usage: warp-switch <profile-name>"
            "$WARP_PROFILE_MANAGER" list
            return 1
        fi
        
        "$WARP_PROFILE_MANAGER" load "$1"
    }
    
    # ===== SIMPLE ONE-WORD TEAM COMMANDS =====
    
    # Daily workflow commands
    alias sync="$TEAM_SYNC sync"           # Morning: get latest team workflows
    alias share="$TEAM_SYNC share"         # Evening: share your workflows
    alias update="$TEAM_SYNC update"       # Alternative to sync
    
    # Profile switching
    alias team="$TEAM_SYNC team"           # Switch to team profile
    alias private="$TEAM_SYNC private"     # Switch to private profile
    
    # Status and info
    alias warp-status="$TEAM_SYNC status"  # Show current status
    alias team-log="$TEAM_SYNC log"        # Show recent team activity
    alias team-workflows="$TEAM_SYNC workflows"  # List all workflows
    alias contributors="$TEAM_SYNC contributors" # Show team contributors
else
    echo "⚠️  Warp team configuration not found"
    echo "   Make sure the team repository is cloned to ~/warp-team-config"
    echo "   And run: chmod +x ~/warp-team-config/scripts/*.sh"
fi
