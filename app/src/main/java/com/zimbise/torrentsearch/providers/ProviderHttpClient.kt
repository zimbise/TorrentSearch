package com.zimbise.torrentsearch.providers

import okhttp3.OkHttpClient
import okhttp3.Request
import org.json.JSONObject

object ProviderHttpClient {
    private val client = OkHttpClient()

    fun search(provider: JSONObject, query: String): String {
        val url = provider.optString("url", "")
        val apiKey = provider.optString("apiKey", "")
        if (url.isEmpty()) return "Provider missing URL"

        val fullUrl = "$url/api/v2.0/indexers/all/results?apikey=$apiKey&t=search&q=$query"
        val request = Request.Builder().url(fullUrl).build()

        client.newCall(request).execute().use { response ->
            return if (response.isSuccessful) {
                response.body?.string() ?: "Empty response"
            } else {
                "Error: ${response.code}"
            }
        }
    }
}
