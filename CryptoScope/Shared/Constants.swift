//
//  Constants.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 17.04.2026.
//

import Foundation

enum Constants {
    enum Currency {
        static let usd = "usd"
        static let eur = "eur"
        static let gbp = "gbp"
    }
    
    enum UserDefaultsKeys {
        static let watchlistCoinIds = "watchlist_coin_ids"
        static let selectedCurrency = "selectedCurrency"
        static let selectedAppearance = "selectedAppearance"
    }
    
    enum Settings {
        static let title = "Settings"
        static let preferencesSection = "Preferences"
        static let aboutSection = "About"
        static let currencyLabel = "Currency"
        static let appearanceLabel = "Appearance"
        static let versionLabel = "Version"
        static let versionNumber = "1.0.0"
        static let dataSourceLabel = "Data source"
        static let dataSourceValue = "CoinGecko"
        static let currencies = ["USD", "EUR", "GBP", "JPY"]
        static let appearances = ["System", "Light", "Dark"]
    }
    
    enum TabBar {
        static let markets = "Markets"
        static let watchlist = "Watchlist"
        static let portfolio = "Portfolio"
        static let settings = "Settings"
        
        enum Icons {
            static let markets = "chart.line.uptrend.xyaxis"
            static let watchlist = "star"
            static let portfolio = "briefcase"
            static let settings = "gearshape"
        }
    }
}
