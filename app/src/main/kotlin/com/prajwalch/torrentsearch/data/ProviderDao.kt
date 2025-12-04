package com.prajwalch.torrentsearch.data

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.prajwalch.torrentsearch.models.TorznabSearchProvider

@Dao
interface ProviderDao {

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertAll(providers: List<TorznabSearchProvider>)

    @Query("SELECT * FROM torznab_search_providers")
    suspend fun getAll(): List<TorznabSearchProvider>
}
