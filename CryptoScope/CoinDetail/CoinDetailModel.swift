//
//  CoinDetailModel.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 16.04.2026.
//

import Foundation
import Observation

@Observable
class CoinDetailModel {
    var coinDetail: CoinDetail? = nil
    var priceHistory: [PricePoint] = []
    var selectedRange: Int = 7
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private let coinId: String
    private let service: DataServiceProtocol
    
    init(coinId: String, service: DataServiceProtocol = MockDataService()) {
        self.coinId = coinId
        self.service = service
    }
    
    var currentPrice: Double {
        coinDetail?.marketData.currentPrice["usd"] ?? 0
    }
    
    var priceChange: Double {
        coinDetail?.marketData.priceChangePercentage24h ?? 0
    }
    
    var marketCap: Double {
        coinDetail?.marketData.marketCap["usd"] ?? 0
    }
    
    var totalVolume: Double {
        coinDetail?.marketData.totalVolume["usd"] ?? 0
    }
    
    var high24h: Double {
        coinDetail?.marketData.high24h["usd"] ?? 0
    }
    
    var low24h: Double {
        coinDetail?.marketData.low24h["usd"] ?? 0
    }
    
    var ath: Double {
        coinDetail?.marketData.ath["usd"] ?? 0
    }
    
    func fetchData() async {
        isLoading = true
        errorMessage = nil
        
        do {
            async let detail = service.fetchCoinDetail(id: coinId)
            async let history = service.fetchPriceHistory(id: coinId, days: selectedRange)
            
            coinDetail = try await detail
            priceHistory = try await history
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func changeRange(days: Int) async {
        selectedRange = days
        priceHistory = (try? await service.fetchPriceHistory(id: coinId, days: days)) ?? []
    }
}
