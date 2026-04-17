//
//  LaunchScreenView.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var isAnimating = false
    @State private var logoScale: CGFloat = 0.75
    @State private var logoOpacity: CGFloat = 0
    @State private var loaderOpacity: CGFloat = 0
    
    var body: some View {
        ZStack {
            // Base background
            Color("BeigeColor")
                .ignoresSafeArea()
            
            // Dot grid texture
            DotsGridView()
            
            // Ambient glow behind logo
            RadialGradient(
                colors: [
                    Color("BrownColor").opacity(0.08),
                    Color.clear
                ],
                center: .center,
                startRadius: 0,
                endRadius: 160
            )
            .frame(width: 320, height: 320)
            
            // Pulse rings
            PulseRingsView(isAnimating: isAnimating)
            
            // Logo + wordmark
            VStack(spacing: 16) {
                LogoMarkView()
                WordmarkView()
            }
            .scaleEffect(logoScale)
            .opacity(logoOpacity)
            
            // Loader at bottom
            VStack {
                Spacer()
                LoaderBarView(isAnimating: isAnimating)
                    .opacity(loaderOpacity)
                    .padding(.bottom, 64)
            }
        }
        .onAppear {
            // Logo entrance
            withAnimation(.spring(response: 0.7, dampingFraction: 0.75).delay(0.1)) {
                logoScale = 1.0
                logoOpacity = 1.0
            }
            // Loader fade in
            withAnimation(.easeOut(duration: 0.5).delay(0.55)) {
                loaderOpacity = 1.0
            }
            // Start pulse rings
            withAnimation(.easeOut(duration: 0.1).delay(0.2)) {
                isAnimating = true
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}
