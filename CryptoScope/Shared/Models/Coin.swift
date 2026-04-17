//
//  Coin.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//

import Foundation

struct Coin: CoinRepresentable, Codable, Identifiable {
    private let priceChangePercentage24hRaw: Double?
    let id: String
    let name: String
    let symbol: String
    let image: String
    let currentPrice: Double
    let marketCapRank: Int
    let sparklineIn7d: SparklineData?
    
    var priceChangePercentage24h: Double {
        priceChangePercentage24hRaw ?? 0
    }
    
    init(id: String, name: String, symbol: String, image: String, currentPrice: Double, priceChangePercentage24h: Double?, marketCapRank: Int, sparklineIn7d: SparklineData?) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.image = image
        self.currentPrice = currentPrice
        self.priceChangePercentage24hRaw = priceChangePercentage24h
        self.marketCapRank = marketCapRank
        self.sparklineIn7d = sparklineIn7d
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, symbol, image
        case currentPrice = "current_price"
        case priceChangePercentage24hRaw = "price_change_percentage_24h"
        case marketCapRank = "market_cap_rank"
        case sparklineIn7d = "sparkline_in_7d"
    }
}

struct SparklineData: Codable {
    let price: [Double]
}
