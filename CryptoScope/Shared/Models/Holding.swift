//
//  Holding.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//

import Foundation
import SwiftData

@Model
class Holding {
    var coinId: String
    var coinName: String
    var coinSymbol: String
    var quantity: Double
    var buyPrice: Double
    var dateAdded: Date
    
    init(coinId: String, coinName: String, coinSymbol: String, quantity: Double, buyPrice: Double, dateAdded: Date = .now) {
        self.coinId = coinId
        self.coinName = coinName
        self.coinSymbol = coinSymbol
        self.quantity = quantity
        self.buyPrice = buyPrice
        self.dateAdded = dateAdded
    }
}
