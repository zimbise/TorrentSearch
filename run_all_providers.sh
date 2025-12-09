#!/data/data/com.termux/files/usr/bin/bash
set -e

REPO_ROOT="$HOME/TorrentSearch"

cd "$REPO_ROOT"

echo "=============================="
echo "🚀 Provider full pipeline start"
echo "=============================="
echo

# 1) Rewrite / repair providers (your Torznab 192.168.1.175 set)
if [ -x ./repair_providers.sh ]; then
    echo "🧩 Running repair_providers.sh ..."
    ./repair_providers.sh
else
    echo "❌ repair_providers.sh not found or not executable."
    echo "   Make sure it's in $REPO_ROOT and chmod +x it."
    exit 1
fi

echo
echo "✅ Provider files rewritten."
echo "------------------------------"

# 2) Cleanup legacy providers + rebuild ProviderRegistry
if [ -x ./cleanup_and_rebuild_providers.sh ]; then
    echo "🧹 Running cleanup_and_rebuild_providers.sh ..."
    ./cleanup_and_rebuild_providers.sh
else
    echo "❌ cleanup_and_rebuild_providers.sh not found or not executable."
    echo "   Make sure it's in $REPO_ROOT and chmod +x it."
    exit 1
fi

echo
echo "✅ Legacy providers cleaned and registry rebuilt."
echo "------------------------------"

# 3) Git status before staging
echo "📌 Git status (before staging):"
git status -sb
echo "------------------------------"

# 4) Stage everything (including deletions)
echo "📦 Staging all changes..."
git add -A

# 5) Commit with a clear message
echo "✅ Committing..."
if git commit -m "Automated provider repair, cleanup, registry rebuild, and build"; then
    echo "✅ Commit created."
else
    echo "ℹ️ No changes to commit (working tree clean)."
fi

echo "------------------------------"

# 6) Push to GitHub
echo "🚀 Pushing to GitHub (origin)..."
if git push; then
    echo "✅ Push succeeded."
else
    echo "❌ Push failed."
    echo "   Check your remote and authentication:"
    echo "     git remote -v"
    echo "   And ensure SSH/HTTPS credentials are set."
fi

echo "------------------------------"

# 7) Build APK (assembleDebug by default)
if [ -x ./gradlew ]; then
    echo "🏗️  Running Gradle build: ./gradlew assembleDebug"
    ./gradlew assembleDebug
    echo "✅ Build completed (assembleDebug)."
else
    echo "⚠️  Gradle wrapper (./gradlew) not found."
    echo "    Skipping build step. If you want builds, ensure ./gradlew exists and is executable."
fi

echo "------------------------------"

# 8) Final diagnostics
echo "📌 Final git status:"
git status -sb

echo
echo "=============================="
echo "✅ Provider full pipeline + build done"
echo "=============================="
