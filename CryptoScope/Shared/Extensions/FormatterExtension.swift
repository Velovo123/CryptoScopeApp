//
//  FormatterExtension.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 16.04.2026.
//

import Foundation

extension Double {
    func formattedAsPrice(currency: String = "usd") -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        formatter.currencyCode = currency.uppercased()
        formatter.maximumFractionDigits = self >= 1 ? 0 : 4
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
    
    func formattedAsCompact(currency: String = "usd") -> String {
        let symbol = currencySymbol(for: currency)
        switch self {
        case 1_000_000_000_000...:
            return String(format: "\(symbol)%.2fT", self / 1_000_000_000_000)
        case 1_000_000_000...:
            return String(format: "\(symbol)%.2fB", self / 1_000_000_000)
        case 1_000_000...:
            return String(format: "\(symbol)%.2fM", self / 1_000_000)
        default:
            return String(format: "\(symbol)%.2f", self)
        }
    }
    
    var formattedAsPercentage: String {
        let prefix = self >= 0 ? "+" : ""
        return prefix + String(format: "%.2f", self) + "%"
    }
    
    private func currencySymbol(for currency: String) -> String {
        switch currency.lowercased() {
        case "usd": return "$"
        case "eur": return "€"
        case "gbp": return "£"
        case "jpy": return "¥"
        default: return "$"
        }
    }
}
