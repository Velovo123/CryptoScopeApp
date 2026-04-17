//
//  SettingsView.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage(Constants.UserDefaultsKeys.selectedCurrency) private var selectedCurrency = Constants.Settings.currencies.first!
    @AppStorage(Constants.UserDefaultsKeys.selectedAppearance) private var selectedAppearance = Constants.Settings.appearances.first!
    
    var body: some View {
        NavigationStack {
            List {
                Section(Constants.Settings.preferencesSection) {
                    Picker(Constants.Settings.currencyLabel, selection: $selectedCurrency) {
                        ForEach(Constants.Settings.currencies, id: \.self) { Text($0).tag($0) }
                    }
                    .listRowBackground(Color.lightBrown.opacity(0.3))
                }
                
                Section(Constants.Settings.aboutSection) {
                    HStack {
                        Text(Constants.Settings.versionLabel)
                        Spacer()
                        Text(Constants.Settings.versionNumber)
                            .foregroundStyle(Color.secondary)
                    }
                    .listRowBackground(Color.lightBrown.opacity(0.3))
                    
                    HStack {
                        Text(Constants.Settings.dataSourceLabel)
                        Spacer()
                        Text(Constants.Settings.dataSourceValue)
                            .foregroundStyle(Color.secondary)
                    }
                    .listRowBackground(Color.lightBrown.opacity(0.3))
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.beige)
            .navigationTitle(Constants.Settings.title)
        }
    }
}

#Preview {
    SettingsView()
}
