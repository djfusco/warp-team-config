#!/bin/bash

# Export workflows from Warp to team repository
set -e

WARP_DB="$HOME/Library/Application Support/dev.warp.Warp-Stable/warp.sqlite"
WORKFLOWS_DIR="$(dirname "$0")/../workflows"

echo "📤 Exporting workflows to team repository..."

if [[ ! -f "$WARP_DB" ]]; then
    echo "❌ Warp database not found at: $WARP_DB"
    exit 1
fi

mkdir -p "$WORKFLOWS_DIR"

# Export workflows
sqlite3 "$WARP_DB" "SELECT json_extract(data, '$.name') as name, data FROM workflows;" | while IFS='|' read -r name data; do
    if [[ "$name" != "name" && -n "$name" ]]; then
        filename=$(echo "$name" | tr ' ' '_' | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9_-]//g')
        
        if command -v jq &> /dev/null; then
            echo "$data" | jq '.' > "$WORKFLOWS_DIR/${filename}.json"
        else
            echo "$data" > "$WORKFLOWS_DIR/${filename}.json"
        fi
        
        echo "✅ Exported: $name -> ${filename}.json"
    fi
done

echo "🎉 Export complete!"
echo "💡 Don't forget to commit and push your changes to share with the team."