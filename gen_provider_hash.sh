#!/data/data/com.termux/files/usr/bin/bash
set -e

REPO_ROOT="$HOME/TorrentSearch"
cd "$REPO_ROOT"

FILES=$(cat <<EOL
app/src/main/kotlin/com/prajwalch/torrentsearch/providers/ProviderRegistry.kt
app/src/main/kotlin/com/prajwalch/torrentsearch/providers
EOL
)

HASH=$(tar -cf - $FILES 2>/dev/null | sha256sum | awk '{print $1}')

ASSETS_DIR="app/src/main/assets"
mkdir -p "$ASSETS_DIR"

echo "$HASH" > "$ASSETS_DIR/provider_hash.txt"
