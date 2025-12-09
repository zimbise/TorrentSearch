package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent

class X1337x : SearchProvider {

    override val info = SearchProviderInfo(
        id = "1337x",
        name = "1337x",
        url = "http://192.168.1.175:9117/api/v2.0/indexers/1337x/results/torznab",
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
