//
//  MarketModel.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//

import Foundation
import Observation

@Observable
class MarketModel {
    var coins: [Coin] = []
    var searchText: String = ""
    var isLoading: Bool = false
    var errorMessage: String? = nil
    var currency: String = Constants.Currency.usd
    
    private let service: DataServiceProtocol
    private var lastFetchTime: Date? = nil
    private let cacheExpiry: TimeInterval = 120
    
    init(service: DataServiceProtocol = AppConfig.service) {
        self.service = service
    }
    
    var isCacheValid: Bool {
        guard let lastFetchTime else { return false }
        return Date().timeIntervalSince(lastFetchTime) < cacheExpiry
    }
    
    var filteredCoins: [Coin] {
        let sorted = coins.sorted { $0.marketCapRank < $1.marketCapRank }
        if searchText.isEmpty { return sorted }
        return sorted.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.symbol.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    func fetchCoins(forceRefresh: Bool = false) async {
        if isCacheValid && !forceRefresh && !coins.isEmpty { return }
        
        isLoading = true
        errorMessage = nil
        
        await withMinimumDuration(seconds: 1.5) {
            do {
                self.coins = try await self.service.fetchCoins(currency: self.currency)
                self.lastFetchTime = Date()
            } catch is CancellationError {
                // ignore
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
        
        isLoading = false
    }
    
    func updateCurrency(_ newCurrency: String) async {
        guard currency != newCurrency else { return }
        currency = newCurrency
        lastFetchTime = nil
        coins = []
        await fetchCoins(forceRefresh: true)
    }
}
