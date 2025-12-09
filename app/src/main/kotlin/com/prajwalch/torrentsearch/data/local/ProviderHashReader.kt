package com.prajwalch.torrentsearch.data.local

import android.content.Context

object ProviderHashReader {
    fun readCurrentHash(context: Context): String? =
        try { context.assets.open("provider_hash.txt").bufferedReader().use { it.readLine() } }
        catch (e: Exception) { null }
}
