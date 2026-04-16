//
//  CoinRowView.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//

import SwiftUI


struct CoinRowView: View {
    let coin: Coin
    private var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.currencyCode = "USD"
        formatter.locale = Locale(identifier: "en_US")
        formatter.maximumFractionDigits = coin.currentPrice >= 1 ? 2 : 4
        return formatter.string(from: NSNumber(value: coin.currentPrice)) ?? ""
    }
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: coin.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Circle()
                    .fill(Color.lightBrown)
            }
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 2) {
                Text(coin.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.primary)
                Text(coin.symbol.uppercased())
                    .font(.caption)
                    .foregroundStyle(Color.secondary)
            }
            
            Spacer()
            
            
            SparklineChartView(prices: coin.sparklineIn7d?.price ?? []).frame(width: 60, height: 30)
            
            VStack(alignment: .trailing, spacing: 2) {
                    Text(formattedPrice)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.primary)
                    Text("\(coin.priceChangePercentage24h >= 0 ? "+" : "")\(coin.priceChangePercentage24h, specifier: "%.2f")%")
                        .font(.caption)
                        .foregroundStyle(coin.priceChangePercentage24h >= 0 ? Color.priceUp : Color.priceDown)
                }
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 8)
    }
}

#Preview {
    CoinRowView(coin: MockData.coins[1])
        .padding()
}
