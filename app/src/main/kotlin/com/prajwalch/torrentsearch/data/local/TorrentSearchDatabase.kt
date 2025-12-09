package com.prajwalch.torrentsearch.data.local

import android.content.Context
import androidx.room.AutoMigration
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase

import com.prajwalch.torrentsearch.data.local.dao.BookmarkedTorrentDao
import com.prajwalch.torrentsearch.data.local.dao.SearchHistoryDao
import com.prajwalch.torrentsearch.data.local.dao.TorznabSearchProviderDao
import com.prajwalch.torrentsearch.data.local.entities.BookmarkedTorrent
import com.prajwalch.torrentsearch.data.local.entities.SearchHistoryEntity
import com.prajwalch.torrentsearch.data.local.entities.TorznabSearchProviderEntity

@Database(
    entities = [
        BookmarkedTorrent::class,
        SearchHistoryEntity::class,
        TorznabSearchProviderEntity::class,
    ],
    version = 2,
    exportSchema = true,
    autoMigrations = [
        AutoMigration(from = 1, to = 2),
    ],
)
abstract class TorrentSearchDatabase : RoomDatabase() {

    abstract fun bookmarkedTorrentDao(): BookmarkedTorrentDao

    abstract fun searchHistoryDao(): SearchHistoryDao

    abstract fun torznabSearchProviderDao(): TorznabSearchProviderDao

    companion object {
        private const val DB_NAME = "torrentsearch.db"

        private var Instance: TorrentSearchDatabase? = null

        fun getInstance(context: Context): TorrentSearchDatabase {
            return Instance ?: createInstance(context)
        }

        private fun createInstance(context: Context): TorrentSearchDatabase {
            val databaseBuilder = Room.databaseBuilder(
                context,
                TorrentSearchDatabase::class.java,
                DB_NAME,
            )

            return databaseBuilder.build().also { Instance = it }
        }
    }
}
