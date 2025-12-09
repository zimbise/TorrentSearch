#!/data/data/com.termux/files/usr/bin/bash
set -e

PROVIDER_DIR="app/src/main/kotlin/com/prajwalch/torrentsearch/providers"
REGISTRY_FILE="$PROVIDER_DIR/ProviderRegistry.kt"

echo "🔍 Scanning providers in $PROVIDER_DIR"

classes=$(
  grep -R --include='*.kt' -h '^class ' "$PROVIDER_DIR" \
    | sed -E 's/^class ([A-Za-z0-9_]+).*/\1/' \
    | grep -v '^ProviderRegistry$' \
    | sort
)

echo "✅ Found provider classes:"
echo "$classes" | sed 's/^/  - /'

echo
echo "🧱 Rebuilding $REGISTRY_FILE"

cat > "$REGISTRY_FILE" << 'EOK'
package com.prajwalch.torrentsearch.providers

object ProviderRegistry {

    val allProviders: List<SearchProvider> by lazy {
        listOf(
EOK

first=1
while read -r cls; do
  [ -z "$cls" ] && continue
  if [ $first -eq 1 ]; then
    echo "            ${cls}()," >> "$REGISTRY_FILE"
    first=0
  else
    echo "            ${cls}()," >> "$REGISTRY_FILE"
  fi
done <<< "$classes"

cat >> "$REGISTRY_FILE" << 'EOK'
        )
    }
}
EOK

echo "✅ ProviderRegistry.kt regenerated."
