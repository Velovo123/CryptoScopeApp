//
//  StatCardView.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 16.04.2026.
//

import SwiftUI

struct StatCardView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(Color.secondary)
            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.lightBrown.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
