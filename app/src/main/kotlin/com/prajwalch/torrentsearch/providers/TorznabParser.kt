package com.prajwalch.torrentsearch.providers

import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.InfoHashOrMagnetUri
import com.prajwalch.torrentsearch.models.Torrent
import com.prajwalch.torrentsearch.utils.prettyDate
import com.prajwalch.torrentsearch.utils.prettyFileSize
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import kotlinx.serialization.json.JsonObject
import org.w3c.dom.Element
import java.net.URLEncoder
import javax.xml.parsers.DocumentBuilderFactory

interface TorznabHttpClient {
    suspend fun getString(url: String): String?
}

data class TorznabSearchContext(
    val httpClient: TorznabHttpClient,
)

object TorznabParser {

    suspend fun search(
        baseUrl: String,
        apiKey: String,
        query: String,
        providerId: String,
        providerName: String,
    ): List<Torrent> = withContext(Dispatchers.IO) {
        val encodedQuery = URLEncoder.encode(query, "UTF-8")
        val url = buildString {
            append(baseUrl)
            if (!baseUrl.contains("?")) {
                append("?")
            } else if (!baseUrl.endsWith("&") && !baseUrl.endsWith("?")) {
                append("&")
            }
            append("apikey=")
            append(apiKey)
            append("&t=search&q=")
            append(encodedQuery)
        }

        val client = object : TorznabHttpClient {
            override suspend fun getString(url: String): String? {
                // This will be replaced by the real app HTTP client integration
                return null
            }
        }

        val xmlString = client.getString(url) ?: return@withContext emptyList<Torrent>()

        parseTorznabXml(
            xmlString = xmlString,
            providerId = providerId,
            providerName = providerName,
        )
    }

    fun parseTorznabXml(
        xmlString: String,
        providerId: String,
        providerName: String,
    ): List<Torrent> {
        val factory = DocumentBuilderFactory.newInstance()
        factory.isNamespaceAware = false
        val builder = factory.newDocumentBuilder()
        val inputStream = xmlString.byteInputStream()
        val doc = builder.parse(inputStream)
        doc.documentElement.normalize()

        val itemNodes = doc.getElementsByTagName("item")
        val torrents = mutableListOf<Torrent>()

        for (i in 0 until itemNodes.length) {
            val node = itemNodes.item(i)
            if (node is Element) {
                val title = node.getElementsByTagName("title")
                    .item(0)?.textContent ?: continue

                val sizeBytes = node.getElementsByTagName("size")
                    .item(0)?.textContent?.toLongOrNull() ?: 0L
                val size = prettyFileSize(sizeBytes.toFloat())

                val seeders = node.getElementsByTagName("torznab:seeders")
                    .item(0)?.textContent?.toUIntOrNull() ?: 0u
                val peers = node.getElementsByTagName("torznab:peers")
                    .item(0)?.textContent?.toUIntOrNull() ?: 0u

                val pubDate = node.getElementsByTagName("pubDate")
                    .item(0)?.textContent ?: ""
                val uploadDate = prettyDateFromRss(pubDate)

                val magnetOrHash = extractMagnetOrInfoHash(node)

                torrents += Torrent(
                    name = title,
                    size = size,
                    seeders = seeders,
                    peers = peers,
                    providerId = providerId,
                    providerName = providerName,
                    uploadDate = uploadDate,
                    descriptionPageUrl = "",
                    infoHashOrMagnetUri = magnetOrHash,
                )
            }
        }

        return torrents
    }

    private fun prettyDateFromRss(rssDate: String): String {
        return rssDate.ifBlank { "" }
    }

    private fun extractMagnetOrInfoHash(element: Element): InfoHashOrMagnetUri {
        val enclosureNodes = element.getElementsByTagName("enclosure")
        for (i in 0 until enclosureNodes.length) {
            val node = enclosureNodes.item(i)
            if (node is Element) {
                val urlAttr = node.getAttribute("url")
                if (urlAttr.startsWith("magnet:?")) {
                    return InfoHashOrMagnetUri.MagnetUri(urlAttr)
                }
            }
        }

        val guid = element.getElementsByTagName("guid")
            .item(0)?.textContent.orEmpty()

        val infoHash = guid
            .removePrefix("urn:btih:")
            .takeIf { it.isNotBlank() }
            ?: ""

        return if (infoHash.isNotBlank()) {
            InfoHashOrMagnetUri.InfoHash(infoHash)
        } else {
            InfoHashOrMagnetUri.MagnetUri("")
        }
    }
}
