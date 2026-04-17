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
                Tab(Constants.TabBar.markets, systemImage: Constants.TabBar.Icons.markets, value: 0) {
                    MarketsView()
                }
                Tab(Constants.TabBar.watchlist, systemImage: Constants.TabBar.Icons.watchlist, value: 1) {
                    WatchlistView()
                }
                Tab(Constants.TabBar.portfolio, systemImage: Constants.TabBar.Icons.portfolio, value: 2) {
                    PortfolioView()
                }
                Tab(Constants.TabBar.settings, systemImage: Constants.TabBar.Icons.settings, value: 3) {
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
