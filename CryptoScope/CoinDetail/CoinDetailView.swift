//
//  CoinDetailView.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 16.04.2026.
//

import SwiftUI

struct CoinDetailView: View {
    @State private var model: CoinDetailModel
    @Environment(WatchlistStore.self) private var watchlistStore
    
    init(coinId: String) {
        _model = State(initialValue: CoinDetailModel(coinId: coinId))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if model.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                } else if let error = model.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                } else {
                    headerSection
                    timeRangeSelector
                    PriceChartView(priceHistory: model.priceHistory)
                    statsSection
                }
            }
            .padding()
        }
        .appBackground()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack(alignment: .firstTextBaseline, spacing: 6) {
                    Text(model.coinDetail?.name ?? "")
                        .font(.title)
                        .fontWeight(.bold)
                    Text(model.coinDetail?.symbol.uppercased() ?? "")
                        .font(.subheadline)
                        .foregroundStyle(Color.secondary)
                }
            }
        }
        .task {
            await model.fetchData()
        }
    }
    
    private var actionButtons: some View {
        HStack(spacing: 12) {
            Button {
                if watchlistStore.contains(model.coinDetail?.id ?? "") {
                    watchlistStore.remove(model.coinDetail?.id ?? "")
                } else {
                    watchlistStore.add(model.coinDetail?.id ?? "")
                }
            } label: {
                Label(
                    watchlistStore.contains(model.coinDetail?.id ?? "") ? "Watchlisted" : "Watchlist",
                    systemImage: watchlistStore.contains(model.coinDetail?.id ?? "") ? "star.fill" : "star"
                )
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(Color.lightBrown.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .foregroundStyle(Color.brown)
        }
        .padding(.top, 8)
    }
    
    // MARK: — Header
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(model.currentPrice.formattedAsPrice)
                .font(.largeTitle)
                .fontWeight(.medium)
            
            Text("\(model.priceChange >= 0 ? "+" : "")\(model.priceChange, specifier: "%.2f")% today")
                .font(.subheadline)
                .foregroundStyle(model.priceChange >= 0 ? Color.priceUp : Color.priceDown)
        }
    }
    
    // MARK: — Time Range
    private var timeRangeSelector: some View {
        HStack {
            ForEach([1, 7, 30, 90], id: \.self) { days in
                Button {
                    Task { await model.changeRange(days: days) }
                } label: {
                    Text(label(for: days))
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(model.selectedRange == days ? Color.brown : Color.clear)
                        .foregroundStyle(model.selectedRange == days ? Color.beige : Color.primary)
                        .clipShape(Capsule())
                }
            }
        }
        .padding(4)
        .background(Color.lightBrown.opacity(0.3))
        .clipShape(Capsule())
    }
    
    // MARK: — Stats
    private var statsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Statistics")
                .font(.headline)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                StatCardView(title: "Market cap", value: model.marketCap.formattedAsCompact)
                StatCardView(title: "24h volume", value: model.totalVolume.formattedAsCompact)
                StatCardView(title: "All time high", value: model.ath.formattedAsCompact)
                StatCardView(title: "24h high", value: model.high24h.formattedAsPrice)
                StatCardView(title: "24h low", value: model.low24h.formattedAsPrice)
            }
            actionButtons
        }
        
    }
    
    private func label(for days: Int) -> String {
        switch days {
        case 1: return "1D"
        case 7: return "7D"
        case 30: return "30D"
        case 90: return "90D"
        default: return "\(days)D"
        }
    }
}

#Preview {
    CoinDetailView(coinId: "bitcoin").environment(WatchlistStore())
}
