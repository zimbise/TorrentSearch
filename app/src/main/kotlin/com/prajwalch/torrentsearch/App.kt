
CoroutineScope(Dispatchers.IO).launch {
    val context = this@App
    val hashStore = ProviderHashStore(context)
    val currentHash = ProviderHashReader.readCurrentHash(context)
    val lastHash = hashStore.getLastHash()

    if (currentHash != null && currentHash != lastHash) {
        searchProvidersRepository.reseedFromRegistry()
        hashStore.setLastHash(currentHash)
    }
}
