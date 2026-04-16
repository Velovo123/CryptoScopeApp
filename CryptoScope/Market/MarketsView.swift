//
//  MarketsView.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//

import SwiftUI

struct MarketsView: View {
    @State private var model = MarketModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if model.isLoading {
                    LoadingView()
                } else if let error = model.errorMessage {
                    ErrorView(message: error) {
                            await model.fetchCoins()
                        }
                } else {
                    coinList
                }
            }.appBackground()
            .navigationTitle("Markets")
            .searchable(text: $model.searchText, prompt: "Search coins...")
            .task {
                await model.fetchCoins()
            }
            .refreshable {
                await model.fetchCoins(forceRefresh: true)
            }
        }
    }
    
    private var coinList: some View {
        List(model.filteredCoins) { coin in
            NavigationLink(destination: CoinDetailView(coinId: coin.id)) {
                CoinRowView(coin: coin)
            }
            .listRowBackground(Color.beige)
        }
        .appBackground()
    }
}

#Preview {
    MarketsView().environment(WatchlistStore())
}
