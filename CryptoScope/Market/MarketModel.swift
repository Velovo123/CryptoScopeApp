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
    
    private let service: DataServiceProtocol
    
    init(service: DataServiceProtocol = MockDataService()) {
        self.service = service
    }
    
    var filteredCoins: [Coin] {
        let sorted = coins.sorted { $0.marketCapRank < $1.marketCapRank }
        
        if searchText.isEmpty {
            return sorted
        }
        
        return sorted.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.symbol.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    func fetchCoins() async {
        isLoading = true
        errorMessage = nil
        
        do {
            coins = try await service.fetchCoins()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
