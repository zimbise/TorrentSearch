#!/data/data/com.termux/files/usr/bin/bash

set -e

PROVIDER_DIR="app/src/main/kotlin/com/prajwalch/torrentsearch/providers"

echo "🔍 Scanning for empty or truncated provider files..."

find "$PROVIDER_DIR" -name '*.kt' | while read -r file; do
    size=$(stat -c%s "$file")
    if [ "$size" -lt 50 ]; then
        echo "❌ Empty or broken: $file"
        rm "$file"
    fi
done

echo
echo "✅ Empty files removed."
echo "----------------------------------------"
echo "📦 Rewriting provider files..."

# ----------------------------------------
# Providers

cat > "$PROVIDER_DIR/ZeroMagnet.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class ZeroMagnet : SearchProvider {

    override val info = SearchProviderInfo(
        id = "0magnet",
        name = "0magnet",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/0magnet/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/X1337x.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class X1337x : SearchProvider {

    override val info = SearchProviderInfo(
        id = "1337x",
        name = "1337x",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/1337x/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/FiftyTwoBt.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class FiftyTwoBt : SearchProvider {

    override val info = SearchProviderInfo(
        id = "52bt",
        name = "52bt",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/52bt/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/Acgrip.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class Acgrip : SearchProvider {

    override val info = SearchProviderInfo(
        id = "acgrip",
        name = "acgrip",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/acgrip/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/BigFanGroup.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class BigFanGroup : SearchProvider {

    override val info = SearchProviderInfo(
        id = "bigfangroup",
        name = "bigfangroup",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/bigfangroup/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/Bitru.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class Bitru : SearchProvider {

    override val info = SearchProviderInfo(
        id = "bitru",
        name = "bitru",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/bitru/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/ExtraTorrentSt.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class ExtraTorrentSt : SearchProvider {

    override val info = SearchProviderInfo(
        id = "extratorrent-st",
        name = "extratorrent-st",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/extratorrent-st/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/FreeJavTorrent.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class FreeJavTorrent : SearchProvider {

    override val info = SearchProviderInfo(
        id = "freejavtorrent",
        name = "freejavtorrent",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/freejavtorrent/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/Idope.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class Idope : SearchProvider {

    override val info = SearchProviderInfo(
        id = "idope",
        name = "idope",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/idope/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/IsoHunt2.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class IsoHunt2 : SearchProvider {

    override val info = SearchProviderInfo(
        id = "isohunt2",
        name = "isohunt2",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/isohunt2/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/KickassTorrentsTo.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class KickassTorrentsTo : SearchProvider {

    override val info = SearchProviderInfo(
        id = "kickasstorrents-to",
        name = "kickasstorrents-to",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/kickasstorrents-to/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/KickassTorrentsWs.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class KickassTorrentsWs : SearchProvider {

    override val info = SearchProviderInfo(
        id = "kickasstorrents-ws",
        name = "kickasstorrents-ws",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/kickasstorrents-ws/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/Knaben.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class Knaben : SearchProvider {

    override val info = SearchProviderInfo(
        id = "knaben",
        name = "knaben",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/knaben/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/MyPornClub.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class MyPornClub : SearchProvider {

    override val info = SearchProviderInfo(
        id = "mypornclub",
        name = "mypornclub",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/mypornclub/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/NorTorrent.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class NorTorrent : SearchProvider {

    override val info = SearchProviderInfo(
        id = "nortorrent",
        name = "nortorrent",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/nortorrent/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/OneJav.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class OneJav : SearchProvider {

    override val info = SearchProviderInfo(
        id = "onejav",
        name = "onejav",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/onejav/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/OpenSharing.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class OpenSharing : SearchProvider {

    override val info = SearchProviderInfo(
        id = "opensharing",
        name = "opensharing",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/opensharing/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/PornoTorrent.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class PornoTorrent : SearchProvider {

    override val info = SearchProviderInfo(
        id = "pornotorrent",
        name = "pornotorrent",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/pornotorrent/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/PornRips.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class PornRips : SearchProvider {

    override val info = SearchProviderInfo(
        id = "pornrips",
        name = "pornrips",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/pornrips/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/RinTorrent.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class RinTorrent : SearchProvider {

    override val info = SearchProviderInfo(
        id = "rintornet",
        name = "rintornet",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/rintornet/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/RuTrackerRu.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class RuTrackerRu : SearchProvider {

    override val info = SearchProviderInfo(
        id = "rutracker-ru",
        name = "rutracker-ru",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/rutracker-ru/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/Sosulki.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class Sosulki : SearchProvider {

    override val info = SearchProviderInfo(
        id = "sosulki",
        name = "sosulki",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/sosulki/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/SukebeinYaasi.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class SukebeinYaasi : SearchProvider {

    override val info = SearchProviderInfo(
        id = "sukebeinyaasi",
        name = "sukebeinyaasi",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/sukebeinyaasi/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/ThePirateBay.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class ThePirateBay : SearchProvider {

    override val info = SearchProviderInfo(
        id = "thepiratebay",
        name = "thepiratebay",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/thepiratebay/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/TheRarbg.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class TheRarbg : SearchProvider {

    override val info = SearchProviderInfo(
        id = "therarbg",
        name = "therarbg",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/therarbg/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/TokyoTosho.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class TokyoTosho : SearchProvider {

    override val info = SearchProviderInfo(
        id = "tokyotosho",
        name = "tokyotosho",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/tokyotosho/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/TorrentCore.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class TorrentCore : SearchProvider {

    override val info = SearchProviderInfo(
        id = "torrentcore",
        name = "torrentcore",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/torrentcore/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/TorrentPirat.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class TorrentPirat : SearchProvider {

    override val info = SearchProviderInfo(
        id = "torrent-pirat",
        name = "torrent-pirat",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/torrent-pirat/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/TorrentDownload.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class TorrentDownload : SearchProvider {

    override val info = SearchProviderInfo(
        id = "torrentdownload",
        name = "torrentdownload",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/torrentdownload/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/TorrentGalaxyClone.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class TorrentGalaxyClone : SearchProvider {

    override val info = SearchProviderInfo(
        id = "torrentgalaxyclone",
        name = "torrentgalaxyclone",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/torrentgalaxyclone/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/TorrentQQ.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class TorrentQQ : SearchProvider {

    override val info = SearchProviderInfo(
        id = "torrentqq",
        name = "torrentqq",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/torrentqq/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/Traht.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class Traht : SearchProvider {

    override val info = SearchProviderInfo(
        id = "traht",
        name = "traht",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/traht/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/U3C3.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class U3C3 : SearchProvider {

    override val info = SearchProviderInfo(
        id = "u3c3",
        name = "u3c3",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/u3c3/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/UIndex.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class UIndex : SearchProvider {

    override val info = SearchProviderInfo(
        id = "uindex",
        name = "uindex",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/uindex/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/XxxClub.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class XxxClub : SearchProvider {

    override val info = SearchProviderInfo(
        id = "xxxclub",
        name = "xxxclub",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/xxxclub/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/XxxTor.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class XxxTor : SearchProvider {

    override val info = SearchProviderInfo(
        id = "xxxtor",
        name = "xxxtor",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/xxxtor/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

cat > "$PROVIDER_DIR/ZkTorrent.kt" << 'EOK'
package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class ZkTorrent : SearchProvider {

    override val info = SearchProviderInfo(
        id = "zktorrent",
        name = "zktorrent",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/zktorrent/results/torznab/",
        specializedCategory = Category.All,
        safetyStatus = SearchProviderSafetyStatus.Safe,
        enabledByDefault = true,
    )

    override suspend fun search(query: String, context: SearchContext): List<Torrent> {
        return TorznabParser.search(
            baseUrl = info.url,
            apiKey = "sfbizvj42r5h41a2aojb2t29zougqd3s",
            query = query,
            providerId = info.id,
            providerName = info.name,
        )
    }
}
EOK

echo "----------------------------------------"
echo "📦 Staging rewritten files..."
find "$PROVIDER_DIR" -name '*.kt' -exec git add {} +

echo "✅ Committing..."
git commit -m "Rewrote provider files with LAN IP and trailing slash"

echo "🚀 Pushing..."
git push

echo
echo "=============================="
echo "🔍 REPO DIAGNOSTICS"
echo "=============================="

echo "📌 Current branch:"
git rev-parse --abbrev-ref HEAD

echo
echo "📌 Remote origin URL:"
git remote get-url origin

echo
echo "📌 Upstream tracking:"
git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null || echo "❌ No upstream set"

echo
echo "📌 Listing tracked provider files:"
git ls-tree -r HEAD --name-only | grep 'providers/' | grep '\.kt$'

echo
echo "📌 Count:"
git ls-tree -r HEAD --name-only | grep 'providers/' | grep '\.kt$' | wc -l

echo "✅ Done."
echo "🧹 Cleaning legacy providers and rebuilding registry..."
./cleanup_and_rebuild_providers.sh
