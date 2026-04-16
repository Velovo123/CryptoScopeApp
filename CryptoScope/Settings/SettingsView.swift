//
//  SettingsView.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedCurrency") private var selectedCurrency = "USD"
    @AppStorage("selectedAppearance") private var selectedAppearance = "System"

    private let currencies = ["USD", "EUR", "GBP", "JPY"]
    private let appearances = ["System", "Light", "Dark"]

    var body: some View {
        NavigationStack {
            List {
                Section("Preferences") {
                    Picker("Currency", selection: $selectedCurrency) {
                        ForEach(currencies, id: \.self) { Text($0).tag($0) }
                    }
                    .listRowBackground(Color.lightBrown.opacity(0.3))

                    Picker("Appearance", selection: $selectedAppearance) {
                        ForEach(appearances, id: \.self) { Text($0).tag($0) }
                    }
                    .listRowBackground(Color.lightBrown.opacity(0.3))
                }

                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundStyle(Color.secondary)
                    }
                    .listRowBackground(Color.lightBrown.opacity(0.3))

                    HStack {
                        Text("Data source")
                        Spacer()
                        Text("CoinGecko")
                            .foregroundStyle(Color.secondary)
                    }
                    .listRowBackground(Color.lightBrown.opacity(0.3))
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.beige)
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
