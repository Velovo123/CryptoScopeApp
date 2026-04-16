//
//  AddHoldingView.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 16.04.2026.
//

import SwiftUI
import SwiftData

struct AddHoldingView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let coins: [Coin]

    @State private var searchText: String = ""
    @State private var selectedCoin: Coin? = nil
    @State private var quantity: String = ""
    @State private var buyPrice: String = ""
    @State private var dateAdded: Date = .now

    private var filteredCoins: [Coin] {
        if searchText.isEmpty { return coins }
        return coins.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.symbol.localizedCaseInsensitiveContains(searchText)
        }
    }

    private var isValid: Bool {
        selectedCoin != nil &&
        Double(quantity) != nil &&
        Double(buyPrice) != nil
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if selectedCoin == nil {
                    coinPicker
                } else {
                    holdingForm
                }
            }
            .navigationTitle("Add Holding")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .foregroundStyle(Color.brown)
                }
                if selectedCoin != nil {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") { saveHolding() }
                            .foregroundStyle(Color.brown)
                            .disabled(!isValid)
                    }
                }
            }
        }
    }

    // MARK: — Coin Picker
    private var coinPicker: some View {
        List(filteredCoins) { coin in
            Button {
                selectedCoin = coin
                buyPrice = String(coin.currentPrice)
            } label: {
                CoinRowView(coin: coin)
            }
            .listRowBackground(Color.beige)
        }
        .searchable(text: $searchText, prompt: "Search coins...")
        .scrollContentBackground(.hidden)
        .background(Color.beige)
    }

    // MARK: — Holding Form
    private var holdingForm: some View {
        Form {
            Section("Selected coin") {
                if let coin = selectedCoin {
                    HStack {
                        Text(coin.name)
                            .fontWeight(.medium)
                        Spacer()
                        Button("Change") { selectedCoin = nil }
                            .foregroundStyle(Color.brown)
                            .font(.caption)
                    }
                    .listRowBackground(Color.lightBrown.opacity(0.3))
                }
            }

            Section("Details") {
                HStack {
                    Text("Quantity")
                    Spacer()
                    TextField("0.00", text: $quantity)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
                .listRowBackground(Color.lightBrown.opacity(0.3))

                HStack {
                    Text("Buy price")
                    Spacer()
                    TextField("0.00", text: $buyPrice)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                }
                .listRowBackground(Color.lightBrown.opacity(0.3))

                DatePicker("Date", selection: $dateAdded, displayedComponents: .date)
                    .listRowBackground(Color.lightBrown.opacity(0.3))
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.beige)
    }

    // MARK: — Save
    private func saveHolding() {
        guard let coin = selectedCoin,
              let qty = Double(quantity),
              let price = Double(buyPrice) else { return }

        let holding = Holding(
            coinId: coin.id,
            coinName: coin.name,
            coinSymbol: coin.symbol,
            quantity: qty,
            buyPrice: price,
            dateAdded: dateAdded
        )

        modelContext.insert(holding)
        dismiss()
    }
}

#Preview {
    AddHoldingView(coins: MockData.coins)
        .environment(WatchlistStore())
}
