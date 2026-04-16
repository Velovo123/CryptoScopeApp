//
//  WatchlistView.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//

import SwiftUI

struct WatchlistView: View {
    @Environment(WatchlistStore.self) private var watchlistStore
    
    @State private var coins: [Coin] = []
    
    private let service: DataServiceProtocol = MockDataService()
    
    var watchedCoins: [Coin] {
        coins.filter { watchlistStore.contains($0.id) }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if watchedCoins.isEmpty {
                    emptyState
                } else {
                    coinList
                }
            }.appBackground()
            .navigationTitle("Watchlist")
            .task {
                await fetchCoins()
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
        .appBackground()
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
        coins = (try? await service.fetchCoins()) ?? []
    }
}

#Preview {
    WatchlistView()
        .environment(WatchlistStore())
}
