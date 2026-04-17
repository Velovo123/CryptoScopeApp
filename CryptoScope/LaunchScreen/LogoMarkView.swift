//
//  DotsGridView.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//

import SwiftUI

struct LogoMarkView: View {
    var body: some View {
        ZStack {
            // Icon background
            RoundedRectangle(cornerRadius: 22)
                .fill(
                    LinearGradient(
                        colors: [
                            Color("LightBrownColor"),
                            Color("BrownColor")
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 80, height: 80)
                .shadow(color: Color("BrownColor").opacity(0.35), radius: 20, x: 0, y: 8)
            
            // Highlight sheen on top half
            RoundedRectangle(cornerRadius: 22)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.12),
                            Color.clear
                        ],
                        startPoint: .top,
                        endPoint: .center
                    )
                )
                .frame(width: 80, height: 80)
            
            // Chart icon
            ChartIconShape()
                .frame(width: 80, height: 80)
        }
    }
}

/// Custom drawn chart line + bar chart inside the icon
struct ChartIconShape: View {
    var body: some View {
        Canvas { context, size in
            let w = size.width
            let h = size.height
            let pad: CGFloat = 18
            
            // --- Bar chart (background, subtle) ---
            let bars: [(CGFloat, CGFloat)] = [
                (0.0, 0.45),
                (0.2, 0.70),
                (0.4, 0.55),
                (0.6, 0.88),
                (0.8, 0.62),
                (1.0, 1.00)
            ]
            let barW: CGFloat = 5
            let barArea = CGRect(
                x: pad,
                y: pad + 6,
                width: w - pad * 2,
                height: h - pad * 2 - 4
            )
            
            for (t, heightRatio) in bars {
                let bx = barArea.minX + t * barArea.width - barW / 2
                let bh = barArea.height * heightRatio
                let by = barArea.maxY - bh
                var barPath = Path()
                barPath.addRoundedRect(
                    in: CGRect(x: bx, y: by, width: barW, height: bh),
                    cornerSize: CGSize(width: 2, height: 2)
                )
                context.fill(barPath, with: .color(.white.opacity(0.18)))
            }
            
            // --- Line chart (foreground) ---
            let points: [CGPoint] = [
                CGPoint(x: pad,           y: h - pad - 8),
                CGPoint(x: pad + (w - pad*2) * 0.2, y: h - pad - (h - pad*2) * 0.45),
                CGPoint(x: pad + (w - pad*2) * 0.4, y: h - pad - (h - pad*2) * 0.30),
                CGPoint(x: pad + (w - pad*2) * 0.6, y: h - pad - (h - pad*2) * 0.55),
                CGPoint(x: pad + (w - pad*2) * 0.8, y: h - pad - (h - pad*2) * 0.40),
                CGPoint(x: w - pad,       y: h - pad - (h - pad*2) * 0.70)
            ]
            
            var linePath = Path()
            linePath.move(to: points[0])
            for i in 1..<points.count {
                let prev = points[i - 1]
                let curr = points[i]
                let cp1 = CGPoint(x: (prev.x + curr.x) / 2, y: prev.y)
                let cp2 = CGPoint(x: (prev.x + curr.x) / 2, y: curr.y)
                linePath.addCurve(to: curr, control1: cp1, control2: cp2)
            }
            
            context.stroke(
                linePath,
                with: .color(.white.opacity(0.95)),
                style: StrokeStyle(lineWidth: 2.2, lineCap: .round, lineJoin: .round)
            )
            
            // Sage dot at peak
            if let last = points.last {
                var dotPath = Path()
                dotPath.addEllipse(in: CGRect(x: last.x - 3.5, y: last.y - 3.5, width: 7, height: 7))
                context.fill(dotPath, with: .color(Color("SageColor")))
            }
        }
    }
}

struct WordmarkView: View {
    var body: some View {
        VStack(spacing: 3) {
            Text("CryptoScope")
                .font(.system(size: 24, weight: .semibold, design: .default))
                .foregroundColor(Color("BrownColor"))
                .tracking(-0.3)
            
            Text("LIVE MARKET DATA")
                .font(.system(size: 10, weight: .regular, design: .default))
                .foregroundColor(Color("AccentColor").opacity(0.7))
                .tracking(1.2)
        }
    }
}

#Preview {
    ZStack {
        Color("BeigeColor").ignoresSafeArea()
        VStack(spacing: 16) {
            LogoMarkView()
            WordmarkView()
        }
    }
}
