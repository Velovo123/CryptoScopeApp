//
//  CryptoScopeApp.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//

import SwiftUI
import SwiftData

@main
struct CryptoScopeApp: App {
    @State private var watchlistStore = WatchlistStore()
    @AppStorage(Constants.UserDefaultsKeys.selectedCurrency) private var selectedCurrency = "USD"
    @State private var showLaunch = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                MainAppView()
                    .environment(watchlistStore)
                    .environment(\.currency, selectedCurrency.lowercased())
                    .preferredColorScheme(.light)
                
                if showLaunch {
                    LaunchScreenView()
                        .transition(.opacity)
                        .zIndex(1)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation(.easeOut(duration: 0.4)) {
                        showLaunch = false
                    }
                }
            }
        }
        .modelContainer(for: Holding.self)
    }
}
