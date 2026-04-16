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
    
    var body: some Scene {
        WindowGroup {
            MainAppView()
                .environment(watchlistStore)
        }.modelContainer(for: Holding.self)
    }
}
