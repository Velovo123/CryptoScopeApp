//
//  WatchlistStore.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 16.04.2026.
//

import Foundation
import Observation

@Observable
class WatchlistStore {
    private let key = Constants.UserDefaultsKeys.watchlistCoinIds
    
    var coinIds: [String] = []
    
    init() {
        load()
    }
    
    func add(_ coinId: String) {
        guard !coinIds.contains(coinId) else { return }
        coinIds.append(coinId)
        save()
    }
    
    func remove(_ coinId: String) {
        coinIds.removeAll { $0 == coinId }
        save()
    }
    
    func contains(_ coinId: String) -> Bool {
        coinIds.contains(coinId)
    }
    
    private func save() {
        UserDefaults.standard.set(coinIds, forKey: key)
    }
    
    private func load() {
        coinIds = UserDefaults.standard.stringArray(forKey: key) ?? []
    }
}
