//
//  Coin.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//

import Foundation

struct Coin: CoinRepresentable, Codable, Identifiable {
    let id: String
    let name: String
    let symbol: String
    let image: String
    let currentPrice: Double
    let priceChangePercentage24h: Double
    let marketCapRank: Int
    let sparklineIn7d: SparklineData?
    
    enum CodingKeys: String, CodingKey {
        case id, name, symbol, image
        case currentPrice = "current_price"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case marketCapRank = "market_cap_rank"
        case sparklineIn7d = "sparkline_in_7d"
    }
}

struct SparklineData: Codable {
    let price: [Double]
}
