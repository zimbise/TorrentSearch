#!/data/data/com.termux/files/usr/bin/bash
set -e

REPO_ROOT="$HOME/TorrentSearch"
PROVIDER_DIR="$REPO_ROOT/app/src/main/kotlin/com/prajwalch/torrentsearch/providers"
REGISTRY_FILE="$PROVIDER_DIR/ProviderRegistry.kt"

cd "$REPO_ROOT"

echo "🔍 Scanning for all SearchProvider classes under $REPO_ROOT ..."

# 1) Find all classes that implement SearchProvider
all_classes_and_files=$(
  rg -n "class\s+([A-Za-z0-9_]+)\s*:\s*SearchProvider" \
     --glob '*.kt' \
     --no-heading \
     "$REPO_ROOT" \
  | sed -E 's@^(.+):[0-9]+:class ([A-Za-z0-9_]+).*@\2 \1@'
)

echo "✅ Found the following SearchProvider classes:"
echo "$all_classes_and_files" | sed 's/^/  - /'

echo
echo "🔎 Separating NEW providers from LEGACY providers ..."

# 2) Classes under the main providers directory = "new providers"
new_classes_and_files=$(
  echo "$all_classes_and_files" | grep "$PROVIDER_DIR" || true
)

# 3) Everything else = legacy
legacy_classes_and_files=$(
  echo "$all_classes_and_files" | grep -v "$PROVIDER_DIR" || true
)

echo "✅ New provider classes (under $PROVIDER_DIR):"
echo "$new_classes_and_files" | sed 's/^/  - /'

echo
echo "✅ Legacy provider classes (outside $PROVIDER_DIR):"
echo "$legacy_classes_and_files" | sed 's/^/  - /'

echo
echo "🎯 Keeping ONLY Torznab-compatible legacy providers: JackettAll, ProwlarrAll, TorznabSearchProvider"

keep_legacy_names="JackettAll ProwlarrAll TorznabSearchProvider"

# 4) Filter legacy: keep only those three by class name
kept_legacy_classes_and_files=""
deleted_legacy_classes_and_files=""

while read -r line; do
  [ -z "$line" ] && continue
  cls=$(echo "$line" | awk '{print $1}')
  file=$(echo "$line" | awk '{print $2}')
  if echo "$keep_legacy_names" | tr ' ' '\n' | grep -qx "$cls"; then
    kept_legacy_classes_and_files+="$line"$'\n'
  else
    deleted_legacy_classes_and_files+="$line"$'\n'
  fi
done <<< "$legacy_classes_and_files"

echo "✅ Legacy providers to KEEP (Torznab-compatible):"
echo "$kept_legacy_classes_and_files" | sed 's/^/  - /'

echo
echo "🗑️ Legacy providers to DELETE:"
echo "$deleted_legacy_classes_and_files" | sed 's/^/  - /'

echo
echo "🗑️ Deleting non-Torznab legacy provider files..."

while read -r line; do
  [ -z "$line" ] && continue
  file=$(echo "$line" | awk '{print $2}')
  if [ -f "$file" ]; then
    echo "  rm $file"
    rm "$file"
  fi
done <<< "$deleted_legacy_classes_and_files"

echo
echo "✅ Legacy cleanup complete."

echo
echo "📦 Building final provider class list (new + kept legacy) ..."

final_classes=$( \
  { echo "$new_classes_and_files"; echo "$kept_legacy_classes_and_files"; } \
  | awk '{print $1}' \
  | sort -u \
)

echo "✅ Final provider classes:"
echo "$final_classes" | sed 's/^/  - /'

echo
echo "🧱 Regenerating $REGISTRY_FILE ..."

mkdir -p "$PROVIDER_DIR"

cat > "$REGISTRY_FILE" << 'EOK'
package com.prajwalch.torrentsearch.providers

object ProviderRegistry {

    val allProviders: List<SearchProvider> by lazy {
        listOf(
EOK

first=1
while read -r cls; do
  [ -z "$cls" ] && continue
  echo "            ${cls}()," >> "$REGISTRY_FILE"
done <<< "$final_classes"

cat >> "$REGISTRY_FILE" << 'EOK'
        )
    }
}
EOK

echo "✅ ProviderRegistry.kt regenerated."

echo
echo "📌 Summary:"
echo "  - New providers kept from: $PROVIDER_DIR"
echo "  - Legacy Torznab providers kept: JackettAll, ProwlarrAll, TorznabSearchProvider (if present)"
echo "  - Non-Torznab legacy providers deleted"
echo "  - Registry now includes:"
echo "$final_classes" | sed 's/^/    • /'

echo
echo "💡 Hint: run ./repair_providers.sh next to rewrite Torznab URLs if needed."
