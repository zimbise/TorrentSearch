package com.prajwalch.torrentsearch.data.local.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.Update
import com.prajwalch.torrentsearch.data.local.entities.TorznabSearchProviderEntity
import kotlinx.coroutines.flow.Flow

@Dao
interface TorznabSearchProviderDao {

    @Query("DELETE FROM torznab_search_providers")
    suspend fun deleteAll()

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertAll(providers: List<TorznabSearchProviderEntity>)

    @Insert(onConflict = OnConflictStrategy.IGNORE)
    suspend fun insert(searchProvider: TorznabSearchProviderEntity)

    @Query("SELECT * FROM torznab_search_providers")
    fun observeAll(): Flow<List<TorznabSearchProviderEntity>>

    @Query("SELECT * FROM torznab_search_providers WHERE id = :id")
    suspend fun findById(id: String): TorznabSearchProviderEntity?

    @Query("SELECT COUNT(id) FROM torznab_search_providers")
    fun observeCount(): Flow<Int>

    @Update
    suspend fun update(searchProvider: TorznabSearchProviderEntity)

    @Query("DELETE FROM torznab_search_providers WHERE id = :id")
    suspend fun deleteById(id: String)
}
