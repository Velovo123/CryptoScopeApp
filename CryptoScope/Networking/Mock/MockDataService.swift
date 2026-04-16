//
//  MockDataService.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//

import Foundation

class MockDataService: DataServiceProtocol {
    func fetchCoins() async throws -> [Coin] {
        MockData.coins
    }
    
    func fetchCoinDetail(id: String) async throws -> CoinDetail {
        MockData.coinDetails[id] ?? MockData.coinDetails["bitcoin"]!
    }

    func fetchPriceHistory(id: String, days: Int) async throws -> [PricePoint] {
        MockData.priceHistories[id] ?? MockData.priceHistory
    }
}
