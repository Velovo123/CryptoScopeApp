//
//  CoinDetail.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//

import Foundation

struct CoinDetail: CoinRepresentable, Codable, Identifiable {
    let id: String
    let name: String
    let symbol: String
    let imageData: CoinDetailImage
    let marketData: MarketData

    // CoinRepresentable
    var image: String { imageData.large }
    var currentPrice: Double { marketData.currentPrice["usd"] ?? 0 }
    var priceChangePercentage24h: Double { marketData.priceChangePercentage24h }

    enum CodingKeys: String, CodingKey {
        case id, name, symbol
        case imageData = "image"
        case marketData = "market_data"
    }
}

struct CoinDetailImage: Codable {
    let large: String
}

struct MarketData: Codable {
    let currentPrice: [String: Double]
    let marketCap: [String: Double]
    let totalVolume: [String: Double]
    let high24h: [String: Double]
    let low24h: [String: Double]
    let ath: [String: Double]
    let circulatingSupply: Double
    let priceChangePercentage24h: Double

    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case totalVolume = "total_volume"
        case high24h = "high_24h"
        case low24h = "low_24h"
        case ath
        case circulatingSupply = "circulating_supply"
        case priceChangePercentage24h = "price_change_percentage_24h"
    }
}
