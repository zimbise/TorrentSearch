package com.prajwalch.torrentsearch.data.local

import android.content.Context
import androidx.core.content.edit

class ProviderHashStore(context: Context) {

    companion object {
        private const val PREF_NAME = "provider_hash_prefs"
        private const val KEY_LAST_HASH = "last_provider_hash"
    }

    private val prefs = context.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE)

    fun getLastHash(): String? = prefs.getString(KEY_LAST_HASH, null)

    fun setLastHash(hash: String) {
        prefs.edit { putString(KEY_LAST_HASH, hash) }
    }
}
