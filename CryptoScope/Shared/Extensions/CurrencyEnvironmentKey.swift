//
//  CurrencyEnvironmentKey.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 17.04.2026.
//

import SwiftUI

struct CurrencyKey: EnvironmentKey {
    static let defaultValue: String = "usd"
}

extension EnvironmentValues {
    var currency: String {
        get { self[CurrencyKey.self] }
        set { self[CurrencyKey.self] = newValue }
    }
}
