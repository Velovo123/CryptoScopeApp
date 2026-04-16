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
    
    static let coinDetails: [String: CoinDetail] = [
        "bitcoin": CoinDetail(
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
        ),
        "ethereum": CoinDetail(
            id: "ethereum",
            name: "Ethereum",
            symbol: "eth",
            image: "https://assets.coingecko.com/coins/images/279/large/ethereum.png",
            marketData: MarketData(
                currentPrice: ["usd": 1587],
                marketCap: ["usd": 190_000_000_000],
                totalVolume: ["usd": 12_000_000_000],
                high24h: ["usd": 1620],
                low24h: ["usd": 1560],
                ath: ["usd": 4878],
                circulatingSupply: 120_000_000,
                priceChangePercentage24h: -1.2
            )
        ),
        "solana": CoinDetail(
            id: "solana",
            name: "Solana",
            symbol: "sol",
            image: "https://assets.coingecko.com/coins/images/4128/large/solana.png",
            marketData: MarketData(
                currentPrice: ["usd": 128.4],
                marketCap: ["usd": 58_000_000_000],
                totalVolume: ["usd": 3_200_000_000],
                high24h: ["usd": 132],
                low24h: ["usd": 124],
                ath: ["usd": 260],
                circulatingSupply: 450_000_000,
                priceChangePercentage24h: 5.1
            )
        ),
        "dogecoin": CoinDetail(
            id: "dogecoin",
            name: "Dogecoin",
            symbol: "doge",
            image: "https://assets.coingecko.com/coins/images/5/large/dogecoin.png",
            marketData: MarketData(
                currentPrice: ["usd": 0.162],
                marketCap: ["usd": 23_000_000_000],
                totalVolume: ["usd": 1_100_000_000],
                high24h: ["usd": 0.170],
                low24h: ["usd": 0.158],
                ath: ["usd": 0.74],
                circulatingSupply: 143_000_000_000,
                priceChangePercentage24h: -0.3
            )
        ),
        "cardano": CoinDetail(
            id: "cardano",
            name: "Cardano",
            symbol: "ada",
            image: "https://assets.coingecko.com/coins/images/975/large/cardano.png",
            marketData: MarketData(
                currentPrice: ["usd": 0.452],
                marketCap: ["usd": 16_000_000_000],
                totalVolume: ["usd": 450_000_000],
                high24h: ["usd": 0.475],
                low24h: ["usd": 0.440],
                ath: ["usd": 3.09],
                circulatingSupply: 35_000_000_000,
                priceChangePercentage24h: -2.1
            )
        ),
        "polkadot": CoinDetail(
            id: "polkadot",
            name: "Polkadot",
            symbol: "dot",
            image: "https://assets.coingecko.com/coins/images/12171/large/polkadot.png",
            marketData: MarketData(
                currentPrice: ["usd": 5.84],
                marketCap: ["usd": 8_500_000_000],
                totalVolume: ["usd": 280_000_000],
                high24h: ["usd": 6.10],
                low24h: ["usd": 5.65],
                ath: ["usd": 55.0],
                circulatingSupply: 1_400_000_000,
                priceChangePercentage24h: 1.8
            )
        ),
        "avalanche-2": CoinDetail(
            id: "avalanche-2",
            name: "Avalanche",
            symbol: "avax",
            image: "https://assets.coingecko.com/coins/images/12559/large/Avalanche_Circle_RedWhite_Trans.png",
            marketData: MarketData(
                currentPrice: ["usd": 19.84],
                marketCap: ["usd": 8_200_000_000],
                totalVolume: ["usd": 320_000_000],
                high24h: ["usd": 20.50],
                low24h: ["usd": 19.20],
                ath: ["usd": 146.22],
                circulatingSupply: 412_000_000,
                priceChangePercentage24h: 3.7
            )
        )
    ]
    
    static let priceHistories: [String: [PricePoint]] = [
        "bitcoin": priceHistory,
        "ethereum": makePriceHistory(prices: [
            1650, 1640, 1620, 1610, 1600, 1580, 1590,
            1575, 1580, 1570, 1565, 1560, 1575, 1580,
            1590, 1585, 1580, 1575, 1570, 1580, 1585,
            1575, 1580, 1590, 1585, 1580, 1585, 1590,
            1585, 1587
        ]),
        "solana": makePriceHistory(prices: [
            115, 116, 118, 117, 119, 120, 121,
            120, 122, 121, 123, 122, 124, 123,
            124, 125, 124, 126, 125, 126, 127,
            126, 127, 128, 127, 128, 127, 128,
            128, 128.4
        ]),
        "dogecoin": makePriceHistory(prices: [
            0.170, 0.169, 0.168, 0.167, 0.166, 0.165, 0.166,
            0.165, 0.164, 0.165, 0.164, 0.163, 0.164, 0.163,
            0.162, 0.163, 0.162, 0.163, 0.162, 0.161, 0.162,
            0.161, 0.162, 0.161, 0.162, 0.161, 0.162, 0.161,
            0.162, 0.162
        ]),
        "cardano": makePriceHistory(prices: [
            0.480, 0.478, 0.475, 0.472, 0.470, 0.468, 0.470,
            0.468, 0.465, 0.463, 0.462, 0.460, 0.461, 0.460,
            0.458, 0.457, 0.456, 0.455, 0.456, 0.455, 0.454,
            0.453, 0.454, 0.453, 0.452, 0.453, 0.452, 0.451,
            0.452, 0.452
        ]),
        "polkadot": makePriceHistory(prices: [
            5.50, 5.52, 5.55, 5.54, 5.56, 5.58, 5.57,
            5.59, 5.60, 5.61, 5.63, 5.62, 5.64, 5.65,
            5.66, 5.67, 5.68, 5.70, 5.71, 5.72, 5.74,
            5.75, 5.76, 5.78, 5.79, 5.80, 5.81, 0.82,
            5.83, 5.84
        ]),
        "avalanche-2": makePriceHistory(prices: [
            18.0, 18.1, 18.3, 18.2, 18.5, 18.6, 18.7,
            18.6, 18.8, 18.9, 19.0, 18.9, 19.1, 19.2,
            19.1, 19.3, 19.2, 19.4, 19.3, 19.5, 19.4,
            19.5, 19.6, 19.7, 19.6, 19.7, 19.8, 19.7,
            19.8, 19.84
        ])
    ]
    
    static func makePriceHistory(prices: [Double]) -> [PricePoint] {
        prices.enumerated().map { index, price in
            PricePoint(
                date: Calendar.current.date(
                    byAdding: .day,
                    value: -(29 - index),
                    to: Date()
                ) ?? Date(),
                price: price
            )
        }
    }

    static let priceHistory = makePriceHistory(prices: [
        76000, 76500, 77200, 76800, 77500, 78000, 77800,
        78500, 79000, 78700, 79500, 80000, 79800, 80500,
        81000, 80800, 81500, 82000, 81800, 82500, 83000,
        82800, 83500, 83000, 82500, 83200, 83500, 83100,
        83400, 83241
    ])
}

