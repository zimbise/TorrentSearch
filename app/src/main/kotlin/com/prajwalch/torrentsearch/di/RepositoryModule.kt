package com.prajwalch.torrentsearch.di

import com.prajwalch.torrentsearch.data.Repository
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import io.ktor.client.*
import io.ktor.client.engine.okhttp.*
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object RepositoryModule {

    @Provides
    @Singleton
    fun provideHttpClient(): HttpClient =
        HttpClient(OkHttp)

    @Provides
    @Singleton
    fun provideRepository(httpClient: HttpClient): Repository =
        Repository(httpClient)
}
