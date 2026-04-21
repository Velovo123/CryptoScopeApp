//
//  PricePoint.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//

import Foundation

struct PricePoint: Identifiable {
    let id = UUID()
    let date: Date
    let price: Double
}
