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
                    ProgressView()
                } else if let error = model.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                } else {
                    coinList
                }
            }
            .navigationTitle("Markets")
            .searchable(text: $model.searchText, prompt: "Search coins...")
            .task {
                await model.fetchCoins()
            }
            .refreshable {
                await model.fetchCoins()
            }
        }
        .appBackground()
    }
    
    private var coinList: some View {
        List(model.filteredCoins) { coin in
            NavigationLink(destination: Text("Coin Detail — coming soon")) {
                CoinRowView(coin: coin)
            }
            .listRowBackground(Color.beige)
        }
        .appBackground()
    }
}

#Preview {
    MarketsView()
}
