suspend fun reseedFromRegistry() {
    // 1. wipe table
    dao.deleteAll()

    // 2. convert registry providers → DB entities
    val entities = ProviderRegistry.allProviders.map { provider ->
        TorznabSearchProviderEntity(
            id = provider.info.id,
            name = provider.info.name,
            url = provider.info.url,
            apiKey = "", // Jackett/Prowlarr don't need per-provider API keys
            category = provider.info.specializedCategory.name,
            unsafeReason = when (provider.info.safetyStatus) {
                is SearchProviderSafetyStatus.Safe -> null
                is SearchProviderSafetyStatus.Unsafe -> provider.info.safetyStatus.reason
            }
        )
    }

    // 3. insert all
    dao.insertAll(entities)
}
