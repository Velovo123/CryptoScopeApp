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
    private var cachedHistories: [Int: [PricePoint]] = [:]
    private var currentTask: Task<Void, Never>? = nil
    private var cachedDetail: CoinDetail? = nil
    private var detailFetchTime: Date? = nil
    private let cacheExpiry: TimeInterval = 120
    
    init(coinId: String, service: DataServiceProtocol = AppConfig.service) {
        self.coinId = coinId
        self.service = service
    }
    
    private var isDetailCacheValid: Bool {
        guard let detailFetchTime else { return false }
        return Date().timeIntervalSince(detailFetchTime) < cacheExpiry
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
        if isDetailCacheValid, let cached = cachedDetail {
            coinDetail = cached
            if let cachedHistory = cachedHistories[selectedRange] {
                priceHistory = cachedHistory
            }
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        await withMinimumDuration(seconds: 1.5) {
            do {
                async let detail = self.service.fetchCoinDetail(id: self.coinId)
                async let history = self.service.fetchPriceHistory(id: self.coinId, days: self.selectedRange)
                
                let fetchedDetail = try await detail
                let fetchedHistory = try await history
                
                self.cachedDetail = fetchedDetail
                self.detailFetchTime = Date()
                self.cachedHistories[self.selectedRange] = fetchedHistory
                self.coinDetail = fetchedDetail
                self.priceHistory = fetchedHistory
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
        
        isLoading = false
    }
    
    func changeRange(days: Int) async {
        selectedRange = days
        
        if let cached = cachedHistories[days] {
            priceHistory = cached
            return
        }
        
        currentTask?.cancel()
        
        currentTask = Task {
            do {
                let history = try await service.fetchPriceHistory(id: coinId, days: days)
                guard !Task.isCancelled else { return }
                cachedHistories[days] = history
                priceHistory = history
            } catch {
                guard !Task.isCancelled else { return }
                errorMessage = error.localizedDescription
            }
        }
        
        await currentTask?.value
    }
}
