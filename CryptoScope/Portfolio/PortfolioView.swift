//
//  PortfolioView.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//

import SwiftUI
import SwiftData

struct PortfolioView: View {
    @State private var model = PortfolioModel()
    @State private var showAddHolding = false
    @Environment(\.modelContext) private var modelContext
    @Environment(\.currency) private var currency
    @Query private var holdings: [Holding]
    
    var body: some View {
        NavigationStack {
            Group {
                if model.isLoading {
                    LoadingView()
                } else if let error = model.errorMessage {
                    ErrorView(message: error) {
                        await model.fetchCoins()
                    }
                } else if holdings.isEmpty {
                    emptyState
                } else {
                    portfolioList
                }
            }
            .navigationTitle("Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddHolding = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(Color.brown)
                    }
                }
            }
            .sheet(isPresented: $showAddHolding) {
                AddHoldingView(coins: model.coins)
            }
            .task {
                model.currency = currency
                await model.fetchCoins()
            }
            .onChange(of: currency) { _, newCurrency in
                model.currency = newCurrency
            }
            .appBackground()
        }
    }
    
    private var portfolioList: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Total value")
                        .font(.caption)
                        .foregroundStyle(Color.secondary)
                    Text(model.totalValue(holdings: holdings).formattedAsPrice(currency: currency))
                        .font(.title)
                        .fontWeight(.medium)
                    PortfolioChartView(holdings: holdings, model: model)
                }
                .padding(.vertical, 8)
                .listRowBackground(Color.beige)
            }
            
            Section("Holdings") {
                ForEach(holdings) { holding in
                    NavigationLink(destination: CoinDetailView(coinId: holding.coinId)) {
                        holdingRow(holding)
                    }
                    .listRowBackground(Color.beige)
                }
                .onDelete(perform: deleteHolding)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.beige)
    }
    
    private func holdingRow(_ holding: Holding) -> some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 2) {
                Text(holding.coinName)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text("\(holding.quantity, specifier: "%.4f") \(holding.coinSymbol.uppercased())")
                    .font(.caption)
                    .foregroundStyle(Color.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text(model.currentValue(for: holding).formattedAsPrice(currency: currency))
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(model.profitLoss(for: holding).formattedAsPrice(currency: currency))
                    .font(.caption)
                    .foregroundStyle(model.profitLoss(for: holding) >= 0 ? Color.priceUp : Color.priceDown)
            }
        }
        .padding(.vertical, 4)
    }
    
    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "briefcase")
                .font(.system(size: 48))
                .foregroundStyle(Color.lightBrown)
            Text("No holdings yet")
                .font(.headline)
            Text("Tap + to add your first holding")
                .font(.subheadline)
                .foregroundStyle(Color.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func deleteHolding(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(holdings[index])
        }
        try? modelContext.save()
    }
}

#Preview {
    PortfolioView()
        .environment(WatchlistStore())
        .modelContainer(for: Holding.self, inMemory: true)
}
