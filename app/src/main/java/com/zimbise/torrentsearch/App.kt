package com.zimbise.torrentsearch

import android.app.Application
import com.zimbise.torrentsearch.providers.ProviderManager

class App : Application() {
    override fun onCreate() {
        super.onCreate()
        ProviderManager.init(this)
    }
}
