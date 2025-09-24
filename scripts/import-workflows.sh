#!/bin/bash

# Import workflows from team repository into Warp
set -e

WARP_DB="$HOME/Library/Application Support/dev.warp.Warp-Stable/warp.sqlite"
WORKFLOWS_DIR="$(dirname "$0")/../workflows"

echo "🔄 Importing workflows from team repository..."

if [[ ! -f "$WARP_DB" ]]; then
    echo "❌ Warp database not found at: $WARP_DB"
    exit 1
fi

if [[ ! -d "$WORKFLOWS_DIR" ]]; then
    echo "❌ Workflows directory not found at: $WORKFLOWS_DIR"
    exit 1
fi

# Create backup
cp "$WARP_DB" "$WARP_DB.backup.$(date +%Y%m%d_%H%M%S)"
echo "✅ Created database backup"

# Import workflows
for workflow_file in "$WORKFLOWS_DIR"/*.json; do
    if [[ -f "$workflow_file" ]]; then
        workflow_name=$(basename "$workflow_file" .json | tr '_' ' ')
        workflow_data=$(cat "$workflow_file")
        
        # Check if workflow already exists
        existing=$(sqlite3 "$WARP_DB" "SELECT COUNT(*) FROM workflows WHERE json_extract(data, '$.name') = '$workflow_name';")
        
        if [[ "$existing" -gt 0 ]]; then
            echo "⚠️  Workflow '$workflow_name' already exists - skipping"
            continue
        fi
        
        # Insert workflow
        sqlite3 "$WARP_DB" "INSERT INTO workflows (data) VALUES ('$(echo "$workflow_data" | sed "s/'/''/g")');"
        echo "✅ Imported: $workflow_name"
    fi
done

echo "🎉 Import complete! Restart Warp to see new workflows."