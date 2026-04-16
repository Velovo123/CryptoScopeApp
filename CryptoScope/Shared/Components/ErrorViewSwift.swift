//
//  ErrorViewSwift.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 16.04.2026.
//

import SwiftUI

struct ErrorView: View {
    let message: String
    let onRetry: () async -> Void

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundStyle(Color.brown)

            Text("Something went wrong")
                .font(.headline)
                .foregroundStyle(Color.primary)

            Text(message)
                .font(.subheadline)
                .foregroundStyle(Color.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button {
                Task { await onRetry() }
            } label: {
                Text("Try again")
                    .fontWeight(.medium)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
                    .background(Color.brown)
                    .foregroundStyle(Color.beige)
                    .clipShape(Capsule())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ErrorView(message: "Too many requests. Please wait a moment.") {}
}
