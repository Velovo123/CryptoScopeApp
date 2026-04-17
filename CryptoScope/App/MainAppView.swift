//
//  MainAppView.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//

import SwiftUI

struct MainAppView: View {
    @State var selection: Int = 0
    
    
    var body: some View {
        VStack{
            TabView(selection: $selection) {
                Tab("Markets", systemImage: "chart.line.uptrend.xyaxis", value: 0) {
                    MarketsView()
                }
                Tab("Watchlist", systemImage: "star", value: 1) {
                    WatchlistView()
                }
                Tab("Portfolio", systemImage: "briefcase", value: 2) {
                    PortfolioView()
                }
                Tab("Settings", systemImage: "gearshape", value: 3) {
                    SettingsView()
                }
            }
            .tint(.brown)
        }
    }
}

#Preview {
    MainAppView().environment(WatchlistStore())
}
