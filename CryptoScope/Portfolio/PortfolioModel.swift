//
//  PortfolioModel.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 16.04.2026.
//

import Foundation
import Observation
import SwiftData

@Observable
class PortfolioModel {
    var coins: [Coin] = []
    var isLoading: Bool = false
    var errorMessage: String? = nil
    var currency: String = Constants.Currency.usd
    
    private let service: DataServiceProtocol
    
    init(service: DataServiceProtocol = AppConfig.service) {
        self.service = service
    }
    
    func currentPrice(for coinId: String) -> Double {
        coins.first { $0.id == coinId }?.currentPrice ?? 0
    }
    
    func currentValue(for holding: Holding) -> Double {
        currentPrice(for: holding.coinId) * holding.quantity
    }
    
    func profitLoss(for holding: Holding) -> Double {
        let current = currentValue(for: holding)
        let cost = holding.buyPrice * holding.quantity
        return current - cost
    }
    
    func totalValue(holdings: [Holding]) -> Double {
        holdings.reduce(0) { $0 + currentValue(for: $1) }
    }
    
    func fetchCoins() async {
        isLoading = true
        errorMessage = nil
        
        await withMinimumDuration(seconds: 1.5) {
            do {
                self.coins = try await self.service.fetchCoins(currency: self.currency)
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
        
        isLoading = false
    }
}
