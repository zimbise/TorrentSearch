package com.prajwalch.torrentsearch.data

import com.prajwalch.torrentsearch.models.TorznabSearchProvider
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import io.ktor.client.*
import io.ktor.client.call.*
import io.ktor.client.request.*
import io.ktor.client.statement.*

class Repository(private val httpClient: HttpClient) {

    suspend fun fetchProvidersFromBridge(): List<TorznabSearchProvider> = withContext(Dispatchers.IO) {
        httpClient.get("http://127.0.0.1:3000/providers").body()
    }

    suspend fun updateProviders(providers: List<TorznabSearchProvider>) {
        // Implement your provider update logic here, e.g., update database
    }
}
