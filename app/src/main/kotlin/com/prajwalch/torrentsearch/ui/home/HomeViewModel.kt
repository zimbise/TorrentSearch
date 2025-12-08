package com.prajwalch.torrentsearch.ui.home

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.prajwalch.torrentsearch.data.Repository
import com.prajwalch.torrentsearch.data.repository.SearchHistoryRepository
import com.prajwalch.torrentsearch.data.repository.SettingsRepository
import com.prajwalch.torrentsearch.models.Category
import com.prajwalch.torrentsearch.models.SearchHistory
import com.prajwalch.torrentsearch.models.SearchHistoryId
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.firstOrNull
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.launch
import javax.inject.Inject

data class HomeUiState(
    val histories: List<SearchHistory> = emptyList(),
    val categories: List<Category> = Category.entries,
    val selectedCategory: Category = Category.All,
    val searchHistoryEnabled: Boolean = true,
    val syncStatus: String = "",
)

private data class HomeSettings(
    val enableNSFWMode: Boolean,
    val saveSearchHistory: Boolean,
    val showSearchHistory: Boolean,
)

@HiltViewModel
class HomeViewModel @Inject constructor(
    private val searchHistoryRepository: SearchHistoryRepository,
    private val settingsRepository: SettingsRepository,
    private val repository: Repository,
) : ViewModel() {

    private val selectedCategory = MutableStateFlow(Category.All)
    private val _syncStatus = MutableStateFlow("")
    val syncStatus: StateFlow<String> = _syncStatus

    val uiState: StateFlow<HomeUiState> =
        combine(
            searchHistoryRepository.observeAllSearchHistories(),
            selectedCategory,
            settingsRepository.getHomeSettings(),
            _syncStatus,
        ) { searchHistories, selectedCategory, settings, syncStatus ->

            val histories =
                if (settings.showSearchHistory) searchHistories else emptyList()

            val categories =
                Category.entries.filter { settings.enableNSFWMode || !it.isNSFW }

            val resolvedCategory =
                if (selectedCategory in categories) selectedCategory else Category.All

            HomeUiState(
                histories = histories,
                categories = categories,
                selectedCategory = resolvedCategory,
                searchHistoryEnabled = settings.saveSearchHistory,
                syncStatus = syncStatus,
            )
        }.stateIn(
            scope = viewModelScope,
            started = SharingStarted.WhileSubscribed(5000),
            initialValue = HomeUiState(),
        )

    init {
        loadDefaultCategory()
    }

    private fun loadDefaultCategory() = viewModelScope.launch {
        val defaultCategory = settingsRepository.defaultCategory.firstOrNull()
        if (defaultCategory != null) {
            selectedCategory.value = defaultCategory
        }
    }

    fun setCategory(category: Category) {
        selectedCategory.value = category
    }

    fun deleteSearchHistory(id: SearchHistoryId) {
        viewModelScope.launch {
            searchHistoryRepository.deleteSearchHistoryById(id)
        }
    }

    fun syncProviders() {
        viewModelScope.launch {
            try {
                _syncStatus.value = "Syncing providers..."
                val providers = repository.fetchProvidersFromBridge()
                repository.updateProviders(providers)
                _syncStatus.value = "Sync successful"
            } catch (e: Exception) {
                _syncStatus.value = "Sync failed: ${e.message}"
            }
        }
    }
}

private fun SettingsRepository.getHomeSettings(): Flow<HomeSettings> =
    combine(
        this.enableNSFWMode,
        this.saveSearchHistory,
        this.showSearchHistory,
        ::HomeSettings,
    )
