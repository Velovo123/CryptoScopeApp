//
//  AppConfig.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 16.04.2026.
//

import Foundation

enum AppConfig {
    static let useMockData = false
    
    static var service: DataServiceProtocol {
        useMockData ? MockDataService() : CoinGeckoService()
    }
    
    static var currency: String {
        UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.selectedCurrency) ?? "USD"
    }
    
    static var currencyCode: String {
        currency.lowercased()
    }
}
