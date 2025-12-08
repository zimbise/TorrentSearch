package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.Torrent
import com.prajwalch.torrentsearch.models.InfoHashOrMagnetUri
import com.prajwalch.torrentsearch.network.HttpClient
import com.prajwalch.torrentsearch.extensions.getArray
import com.prajwalch.torrentsearch.extensions.getObject
import com.prajwalch.torrentsearch.extensions.getString
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonObject
import kotlinx.serialization.json.jsonObject

sealed class SearchProviderSafetyStatus {
    object Safe : SearchProviderSafetyStatus()
    data class Unsafe(val reason: String) : SearchProviderSafetyStatus()
}

enum class SearchProviderType {
    Builtin,
    Torznab
}

typealias SearchProviderId = String

data class SearchProviderInfo(
    val id: SearchProviderId,
    val name: String,
    val url: String,
    val specializedCategory: Category,
    val safetyStatus: SearchProviderSafetyStatus,
    val enabledByDefault: Boolean,
    val type: SearchProviderType,
)

data class TorznabSearchProviderConfig(
    val id: SearchProviderId,
    val name: String,
    val url: String,
    val apiKey: String,
    val category: Category,
    val safetyStatus: SearchProviderSafetyStatus,
    val enabledByDefault: Boolean,
)

data class SearchContext(
    val category: Category,
    val httpClient: HttpClient,
)

interface SearchProvider {
    val info: SearchProviderInfo

    suspend fun search(
        query: String,
        context: SearchContext,
    ): List<Torrent>
}

/**
 * Torznab provider using a Jackett/Prowlarr compatible backend.
 */
class TorznabSearchProvider(
    private val config: TorznabSearchProviderConfig,
) : SearchProvider {

    override val info: SearchProviderInfo = SearchProviderInfo(
        id = config.id,
        name = config.name,
        url = config.url,
        specializedCategory = config.category,
        safetyStatus = config.safetyStatus,
        enabledByDefault = config.enabledByDefault,
        type = SearchProviderType.Torznab,
    )

    override suspend fun search(
        query: String,
        context: SearchContext,
    ): List<Torrent> {
        val base = config.url.trimEnd('/')
        val url = "$base?apikey=${config.apiKey}&t=search&q=$query"

        val json = context.httpClient.getJson(url) ?: return emptyList()
        val root = json.jsonObject

        val items = root.getArray("items") ?: root.getArray("results") ?: return emptyList()

        return items.mapNotNull { element ->
            val obj: JsonObject = try {
                element.jsonObject
            } catch (_: Exception) {
                return@mapNotNull null
            }

            val title = obj.getString("title") ?: obj.getString("name") ?: return@mapNotNull null
            val size = obj.getString("size") ?: obj.getString("size_pretty") ?: "Unknown"
            val seeders = obj.getString("seeders")?.toUIntOrNull() ?: 0u
            val peers = obj.getString("peers")?.toUIntOrNull() ?: 0u
            val categoryName = obj.getString("category") ?: config.category.name
            val category = runCatching { Category.valueOf(categoryName) }.getOrDefault(config.category)
            val details = obj.getString("details") ?: obj.getString("info_url") ?: ""
            val magnet = obj.getString("magneturi") ?: obj.getString("magnet") ?: ""

            Torrent(
                name = title,
                size = size,
                seeders = seeders,
                peers = peers,
                providerId = info.id,
                providerName = info.name,
                uploadDate = obj.getString("pubdate") ?: "",
                category = category,
                descriptionPageUrl = details,
                infoHashOrMagnetUri = InfoHashOrMagnetUri.MagnetUri(uri = magnet),
            )
        }
    }
}
