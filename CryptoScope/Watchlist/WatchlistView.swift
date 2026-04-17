//
//  WatchlistView.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//

import SwiftUI

struct WatchlistView: View {
    @Environment(WatchlistStore.self) private var watchlistStore
    @Environment(\.currency) private var currency
    
    @State private var coins: [Coin] = []
    @State private var isLoading = false
    @State private var errorMessage: String? = nil
    
    private let service: DataServiceProtocol = AppConfig.service
    
    var watchedCoins: [Coin] {
        coins.filter { watchlistStore.contains($0.id) }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if isLoading {
                    LoadingView()
                } else if let error = errorMessage {
                    ErrorView(message: error) {
                        await fetchCoins()
                    }
                } else if watchedCoins.isEmpty {
                    emptyState
                } else {
                    coinList
                }
            }
            .appBackground()
            .navigationTitle(Constants.TabBar.watchlist)
            .task {
                await fetchCoins()
            }
            .onChange(of: currency) { _, _ in
                Task { await fetchCoins() }
            }
        }
    }
    
    private var coinList: some View {
        List(watchedCoins) { coin in
            NavigationLink(destination: CoinDetailView(coinId: coin.id)) {
                CoinRowView(coin: coin)
            }
            .listRowBackground(Color.beige)
            .swipeActions(edge: .trailing) {
                Button(role: .destructive) {
                    watchlistStore.remove(coin.id)
                } label: {
                    Label("Remove", systemImage: "star.slash")
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
    
    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "star.slash")
                .font(.system(size: 48))
                .foregroundStyle(Color.lightBrown)
            Text("No coins in watchlist")
                .font(.headline)
                .foregroundStyle(Color.primary)
            Text("Add coins from the Markets screen")
                .font(.subheadline)
                .foregroundStyle(Color.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func fetchCoins() async {
        isLoading = true
        errorMessage = nil
        
        await withMinimumDuration(seconds: 1.5) {
            do {
                self.coins = try await self.service.fetchCoins(currency: self.currency)
            } catch is CancellationError {
                // ignore
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
        
        isLoading = false
    }
}

#Preview {
    WatchlistView()
        .environment(WatchlistStore())
}
