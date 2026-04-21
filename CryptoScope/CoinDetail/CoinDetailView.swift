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
    @Environment(\.modelContext) private var modelContext
    @Environment(\.currency) private var currency
    @State private var showAddHolding = false
    
    init(coinId: String) {
        _model = State(initialValue: CoinDetailModel(coinId: coinId))
    }
    
    var body: some View {
        Group {
            if model.isLoading {
                LoadingView()
            } else if let error = model.errorMessage {
                ErrorView(message: error) {
                    await model.fetchData()
                }
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        headerSection
                        timeRangeSelector
                        PriceChartView(priceHistory: model.priceHistory)
                        statsSection
                    }
                    .padding()
                }
            }
        }
        .onChange(of: currency) { _, newCurrency in
            Task { await model.updateCurrency(newCurrency) }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .appBackground()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack(spacing: 0) {
                    Text(model.coinDetail?.name ?? "")
                        .font(.headline)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                    Text(model.coinDetail?.symbol.uppercased() ?? "")
                        .font(.caption)
                        .foregroundStyle(Color.secondary)
                }
            }
        }
        .task {
            model.currency = currency
            await model.fetchData()
        }
        .sheet(isPresented: $showAddHolding) {
            AddHoldingView(coins: [model.coinDetail].compactMap { detail in
                guard let detail else { return nil }
                return Coin(
                    id: detail.id,
                    name: detail.name,
                    symbol: detail.symbol,
                    image: detail.image,
                    currentPrice: detail.currentPrice,
                    priceChangePercentage24h: detail.priceChangePercentage24h,
                    marketCapRank: 0,
                    sparklineIn7d: nil
                )
            })
        }
    }
    

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(model.currentPrice.formattedAsPrice(currency: model.currency))
                .font(.largeTitle)
                .fontWeight(.medium)
            
            Text(model.priceChange.formattedAsPercentage + " today")
                .font(.subheadline)
                .foregroundStyle(model.priceChange >= 0 ? Color.priceUp : Color.priceDown)
        }
    }
    

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
    

    private var statsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Statistics")
                .font(.headline)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                StatCardView(title: "Market cap", value: model.marketCap.formattedAsCompact(currency: model.currency))
                StatCardView(title: "24h volume", value: model.totalVolume.formattedAsCompact(currency: model.currency))
                StatCardView(title: "All time high", value: model.ath.formattedAsCompact(currency: model.currency))
                StatCardView(title: "24h high", value: model.high24h.formattedAsPrice(currency: model.currency))
                StatCardView(title: "24h low", value: model.low24h.formattedAsPrice(currency: model.currency))
            }
            actionButtons
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
            
            Button {
                showAddHolding = true
            } label: {
                Label("Portfolio", systemImage: "plus")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(Color.brown)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .foregroundStyle(Color.beige)
        }
        .padding(.top, 8)
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
    CoinDetailView(coinId: "bitcoin")
        .environment(WatchlistStore())
}
