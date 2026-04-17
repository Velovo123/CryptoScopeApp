//
//  LoadingView.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 16.04.2026.
//

import SwiftUI

struct LoadingView: View {
    let action: () async -> Void
    @State private var hasAppeared = false
    
    init(action: @escaping () async -> Void = {}) {
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 12) {
            ProgressView()
                .progressViewStyle(.circular)
                .tint(Color.brown)
                .scaleEffect(1.5)
            
            Text("Loading...")
                .font(.subheadline)
                .foregroundStyle(Color.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .task {
            guard !hasAppeared else { return }
            hasAppeared = true
            try? await Task.sleep(for: .seconds(5))
            await action()
        }
    }
}

#Preview {
    LoadingView()
}
