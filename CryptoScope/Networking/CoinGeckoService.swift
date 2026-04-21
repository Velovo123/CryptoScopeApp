//
//  CoinGeckoService.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 16.04.2026.
//

import Foundation

class CoinGeckoService: DataServiceProtocol {
    
    private let baseURL = "https://api.coingecko.com/api/v3"
    private let session = URLSession.shared
    

    func fetchCoins(currency: String) async throws -> [Coin] {
        let urlString = "\(baseURL)/coins/markets?vs_currency=\(currency)&order=market_cap_desc&per_page=50&sparkline=true&price_change_percentage=24h"
        
        guard let url = URL(string: urlString) else {
            throw ServiceError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        try validateResponse(response)
        return try JSONDecoder().decode([Coin].self, from: data)
    }
    

    func fetchCoinDetail(id: String, currency: String) async throws -> CoinDetail {
        let urlString = "\(baseURL)/coins/\(id)?market_data=true&vs_currency=\(currency)&community_data=false&developer_data=false&tickers=false"
        
        guard let url = URL(string: urlString) else {
            throw ServiceError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        try validateResponse(response)
        return try JSONDecoder().decode(CoinDetail.self, from: data)
    }
    

    func fetchPriceHistory(id: String, days: Int, currency: String) async throws -> [PricePoint] {
        let urlString = "\(baseURL)/coins/\(id)/market_chart?vs_currency=\(currency)&days=\(days)"
        
        guard let url = URL(string: urlString) else {
            throw ServiceError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        try validateResponse(response)
        
        let chartData = try JSONDecoder().decode(MarketChartResponse.self, from: data)
        
        return chartData.prices.map { point in
            PricePoint(
                date: Date(timeIntervalSince1970: point[0] / 1000),
                price: point[1]
            )
        }
    }
    

    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ServiceError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            break
        case 429:
            throw ServiceError.rateLimited
        default:
            throw ServiceError.httpError(httpResponse.statusCode)
        }
    }
}


private struct MarketChartResponse: Codable {
    let prices: [[Double]]
}


enum ServiceError: LocalizedError {
    case invalidURL
    case invalidResponse
    case rateLimited
    case httpError(Int)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .rateLimited:
            return "Too many requests. Please wait a moment."
        case .httpError(let code):
            return "Server error: \(code)"
        }
    }
}
