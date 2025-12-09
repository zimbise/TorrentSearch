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
