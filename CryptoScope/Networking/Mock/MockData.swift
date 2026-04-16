//
//  MockData.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//

import Foundation

struct MockData {
    static let coins: [Coin] = [
        Coin(
            id: "bitcoin",
            name: "Bitcoin",
            symbol: "btc",
            image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png",
            currentPrice: 83241,
            priceChangePercentage24h: 2.4,
            marketCapRank: 1,
            sparklineIn7d: SparklineData(price: [78000, 79500, 80200, 81000, 80500, 82000, 83241])
        ),
        Coin(
            id: "ethereum",
            name: "Ethereum",
            symbol: "eth",
            image: "https://assets.coingecko.com/coins/images/279/large/ethereum.png",
            currentPrice: 1587,
            priceChangePercentage24h: -1.2,
            marketCapRank: 2,
            sparklineIn7d: SparklineData(price: [1650, 1620, 1600, 1580, 1590, 1575, 1587])
        ),
        Coin(
            id: "solana",
            name: "Solana",
            symbol: "sol",
            image: "https://assets.coingecko.com/coins/images/4128/large/solana.png",
            currentPrice: 128.4,
            priceChangePercentage24h: 5.1,
            marketCapRank: 3,
            sparklineIn7d: SparklineData(price: [115, 118, 120, 122, 125, 127, 128.4])
        ),
        Coin(
            id: "dogecoin",
            name: "Dogecoin",
            symbol: "doge",
            image: "https://assets.coingecko.com/coins/images/5/large/dogecoin.png",
            currentPrice: 0.162,
            priceChangePercentage24h: -0.3,
            marketCapRank: 4,
            sparklineIn7d: SparklineData(price: [0.170, 0.168, 0.165, 0.163, 0.164, 0.161, 0.162])
        ),
        Coin(
            id: "avalanche-2",
            name: "Avalanche",
            symbol: "avax",
            image: "https://assets.coingecko.com/coins/images/12559/large/Avalanche_Circle_RedWhite_Trans.png",
            currentPrice: 19.84,
            priceChangePercentage24h: 3.7,
            marketCapRank: 5,
            sparklineIn7d: SparklineData(price: [18.0, 18.5, 19.0, 18.8, 19.2, 19.5, 19.84])
        ),
        Coin(
            id: "cardano",
            name: "Cardano",
            symbol: "ada",
            image: "https://assets.coingecko.com/coins/images/975/large/cardano.png",
            currentPrice: 0.452,
            priceChangePercentage24h: -2.1,
            marketCapRank: 6,
            sparklineIn7d: SparklineData(price: [0.480, 0.475, 0.468, 0.460, 0.455, 0.450, 0.452])
        ),
        Coin(
            id: "polkadot",
            name: "Polkadot",
            symbol: "dot",
            image: "https://assets.coingecko.com/coins/images/12171/large/polkadot.png",
            currentPrice: 5.84,
            priceChangePercentage24h: 1.8,
            marketCapRank: 7,
            sparklineIn7d: SparklineData(price: [5.50, 5.60, 5.65, 5.70, 5.75, 5.80, 5.84])
        )
    ]
    
    static let coinDetail: CoinDetail = CoinDetail(
        id: "bitcoin",
        name: "Bitcoin",
        symbol: "btc",
        image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png",
        marketData: MarketData(
            currentPrice: ["usd": 83241],
            marketCap: ["usd": 1_640_000_000_000],
            totalVolume: ["usd": 38_200_000_000],
            high24h: ["usd": 84_500],
            low24h: ["usd": 81_000],
            ath: ["usd": 108_000],
            circulatingSupply: 19_700_000,
            priceChangePercentage24h: 2.4
        )
    )
    
    static let priceHistory: [PricePoint] = {
        let prices: [Double] = [
            76000, 76500, 77200, 76800, 77500, 78000, 77800,
            78500, 79000, 78700, 79500, 80000, 79800, 80500,
            81000, 80800, 81500, 82000, 81800, 82500, 83000,
            82800, 83500, 83000, 82500, 83200, 83500, 83100,
            83400, 83241
        ]
        
        return prices.enumerated().map { index, price in
            PricePoint(
                date: Calendar.current.date(
                    byAdding: .day,
                    value: -( 29 - index),
                    to: Date()
                ) ?? Date(),
                price: price
            )
        }
    }()
}

