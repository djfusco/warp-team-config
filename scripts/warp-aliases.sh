#!/bin/bash

# Warp Profile Management Aliases
# Source this file in your shell profile (.zshrc, .bashrc, etc.)

WARP_PROFILE_MANAGER="$HOME/warp-team-config/scripts/warp-profile-manager.sh"

# Check if the profile manager exists
if [[ -x "$WARP_PROFILE_MANAGER" ]]; then
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
else
    echo "⚠️  Warp profile manager not found at: $WARP_PROFILE_MANAGER"
    echo "   Make sure the team repository is cloned to ~/warp-team-config"
fi