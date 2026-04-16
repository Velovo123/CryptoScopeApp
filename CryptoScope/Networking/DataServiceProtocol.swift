//
//  DataServiceProtocol.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//

import Foundation

protocol DataServiceProtocol {
    func fetchCoins() async throws -> [Coin]
    func fetchCoinDetail(id: String) async throws -> CoinDetail
    func fetchPriceHistory(id: String, days: Int) async throws -> [PricePoint]
}
