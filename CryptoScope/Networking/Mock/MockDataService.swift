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
        MockData.coinDetail
    }
    
    func fetchPriceHistory(id: String, days: Int) async throws -> [PricePoint] {
        MockData.priceHistory
    }
}
