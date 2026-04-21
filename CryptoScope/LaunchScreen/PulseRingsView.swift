//
//  PulseRingsView.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//

import SwiftUI

struct PulseRingsView: View {
    let isAnimating: Bool
    

    private let rings: [(delay: Double, maxScale: CGFloat, opacity: CGFloat)] = [
        (0.0,  1.6, 0.35),
        (0.55, 1.9, 0.20),
        (1.1,  2.2, 0.10)
    ]
    
    var body: some View {
        ZStack {
            ForEach(rings.indices, id: \.self) { i in
                PulseRing(
                    isAnimating: isAnimating,
                    delay: rings[i].delay,
                    maxScale: rings[i].maxScale,
                    maxOpacity: rings[i].opacity
                )
            }
        }
    }
}

struct PulseRing: View {
    let isAnimating: Bool
    let delay: Double
    let maxScale: CGFloat
    let maxOpacity: CGFloat
    
    @State private var scale: CGFloat = 0.5
    @State private var opacity: CGFloat = 0
    
    var body: some View {
        Circle()
            .stroke(Color("AccentColor"), lineWidth: 0.75)
            .frame(width: 130, height: 130)
            .scaleEffect(scale)
            .opacity(opacity)
            .onChange(of: isAnimating) { _, animating in
                guard animating else { return }
                startPulsing()
            }
            .onAppear {
                if isAnimating { startPulsing() }
            }
    }
    
    private func startPulsing() {

        scale = 0.5
        opacity = 0
        
        let baseAnimation = Animation
            .easeOut(duration: 3.0)
            .delay(delay)
            .repeatForever(autoreverses: false)
        
        withAnimation(baseAnimation) {
            scale = maxScale
            opacity = 0
        }
        

        withAnimation(.easeIn(duration: 0.4).delay(delay)) {
            opacity = maxOpacity
        }
    }
}

#Preview {
    ZStack {
        Color("BeigeColor").ignoresSafeArea()
        PulseRingsView(isAnimating: true)
    }
}
