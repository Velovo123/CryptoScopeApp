//
//  AppConfig.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 16.04.2026.
//

import Foundation

enum AppConfig {
    static let useMockData = false  // ← switch here
    
    static var service: DataServiceProtocol {
        useMockData ? MockDataService() : CoinGeckoService()
    }
}
