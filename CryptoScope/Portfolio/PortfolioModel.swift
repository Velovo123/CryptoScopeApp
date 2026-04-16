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

    private let service: DataServiceProtocol

    init(service: DataServiceProtocol = MockDataService()) {
        self.service = service
    }

    // current price for a holding
    func currentPrice(for coinId: String) -> Double {
        coins.first { $0.id == coinId }?.currentPrice ?? 0
    }

    // total value of a single holding
    func currentValue(for holding: Holding) -> Double {
        currentPrice(for: holding.coinId) * holding.quantity
    }

    // profit/loss of a single holding
    func profitLoss(for holding: Holding) -> Double {
        let current = currentValue(for: holding)
        let cost = holding.buyPrice * holding.quantity
        return current - cost
    }

    // total portfolio value
    func totalValue(holdings: [Holding]) -> Double {
        holdings.reduce(0) { $0 + currentValue(for: $1) }
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
