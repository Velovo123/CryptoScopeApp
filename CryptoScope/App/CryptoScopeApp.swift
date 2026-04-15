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
    var body: some Scene {
        WindowGroup {
            Text("CryptoScope")
        }.modelContainer(for: Holding.self)
    }
}
