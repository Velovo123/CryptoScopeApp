//
//  FormatterExtension.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 16.04.2026.
//

import Foundation

extension Double {
    var formattedAsPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.locale = Locale(identifier: "en_US")
        formatter.maximumFractionDigits = self >= 1 ? 0 : 4
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
    
    var formattedAsPercentage: String {
        let prefix = self >= 0 ? "+" : ""
        return prefix + String(format: "%.2f", self) + "%"
    }
    
    var formattedAsCompact: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_US")
        
        switch self {
        case 1_000_000_000_000...:
            return String(format: "$%.2fT", self / 1_000_000_000_000)
        case 1_000_000_000...:
            return String(format: "$%.2fB", self / 1_000_000_000)
        case 1_000_000...:
            return String(format: "$%.2fM", self / 1_000_000)
        case 1_000...:
            return String(format: "$%.2fK", self / 1_000)
        default:
            return String(format: "$%.2f", self)
        }
    }
}
