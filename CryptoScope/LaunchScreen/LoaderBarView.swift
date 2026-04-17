//
//  DotsGridView.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//

import SwiftUI

struct LoaderBarView: View {
    let isAnimating: Bool
    
    @State private var fillWidth: CGFloat = 0
    @State private var fillOffset: CGFloat = 0
    
    private let trackWidth: CGFloat = 60
    private let barHeight: CGFloat = 2.5
    
    var body: some View {
        ZStack(alignment: .leading) {
            // Track
            Capsule()
                .fill(Color("AccentColor").opacity(0.18))
                .frame(width: trackWidth, height: barHeight)
            
            // Animated fill
            Capsule()
                .fill(Color("AccentColor"))
                .frame(width: fillWidth, height: barHeight)
                .offset(x: fillOffset)
        }
        .frame(width: trackWidth, height: barHeight)
        .onChange(of: isAnimating) { _, animating in
            guard animating else { return }
            runLoop()
        }
        .onAppear {
            if isAnimating { runLoop() }
        }
    }
    
    private func runLoop() {
        fillWidth = 0
        fillOffset = 0
        
        // Phase 1: sweep right
        withAnimation(.easeInOut(duration: 0.9)) {
            fillWidth = trackWidth * 0.7
        }
        
        // Phase 2: exit right
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            withAnimation(.easeIn(duration: 0.5)) {
                fillOffset = trackWidth
                fillWidth = 0
            }
        }
        
        // Loop
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            fillOffset = 0
            fillWidth = 0
            runLoop()
        }
    }
}

#Preview {
    ZStack {
        Color("BeigeColor").ignoresSafeArea()
        LoaderBarView(isAnimating: true)
    }
}
