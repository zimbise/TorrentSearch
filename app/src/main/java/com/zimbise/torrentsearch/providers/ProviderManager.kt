package com.zimbise.torrentsearch.providers

import android.content.Context
import org.json.JSONObject

object ProviderManager {
    private val providers: MutableList<JSONObject> = mutableListOf()

    fun init(context: Context) {
        val arr = ProviderLoader.loadAll(context)
        providers.clear()
        for (i in 0 until arr.length()) {
            val obj = arr.getJSONObject(i)
            obj.put("enabled", true)
            providers.add(obj)
        }
    }

    fun getEnabledProviders(): List<JSONObject> {
        return providers.filter { it.optBoolean("enabled", true) }
    }

    fun searchAll(query: String): List<String> {
        val results = mutableListOf<String>()
        for (provider in getEnabledProviders()) {
            val name = provider.optString("name", "unknown")
            val res = ProviderHttpClient.search(provider, query)
            results.add("[$name] $res")
        }
        return results
    }
}
