//
//  CoinRepresentable.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//

import Foundation

protocol CoinRepresentable {
    var id: String { get }
    var name: String { get }
    var symbol: String { get }
    var image: String { get }
    var currentPrice: Double { get }
    var priceChangePercentage24h: Double { get }
}
