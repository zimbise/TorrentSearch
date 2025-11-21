package com.zimbise.torrentsearch.providers

import android.content.Context
import org.json.JSONArray
import java.io.BufferedReader
import java.io.InputStreamReader

object ProviderLoader {
    fun loadAll(context: Context): JSONArray {
        val am = context.assets
        val files = am.list("providers") ?: emptyArray()
        val arr = JSONArray()
        for (f in files) {
            am.open("providers/$f").use { input ->
                BufferedReader(InputStreamReader(input)).use { br ->
                    val text = br.readText()
                    arr.put(org.json.JSONObject(text))
                }
            }
        }
        return arr
    }
}
