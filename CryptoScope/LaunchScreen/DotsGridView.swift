//
//  DotsGridView.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//

import SwiftUI

struct DotsGridView: View {
    var body: some View {
        GeometryReader { geo in
            Canvas { context, size in
                let spacing: CGFloat = 22
                let dotRadius: CGFloat = 1.0
                let center = CGPoint(x: size.width / 2, y: size.height / 2)
                let maxDist = min(size.width, size.height) * 0.55
                
                let cols = Int(size.width / spacing) + 2
                let rows = Int(size.height / spacing) + 2
                
                for row in 0...rows {
                    for col in 0...cols {
                        let x = CGFloat(col) * spacing
                        let y = CGFloat(row) * spacing
                        
                        let dx = x - center.x
                        let dy = y - center.y
                        let dist = sqrt(dx * dx + dy * dy)
                        
                        // Fade out dots toward edges
                        let alpha = max(0, 1 - (dist / maxDist))
                        guard alpha > 0.01 else { continue }
                        
                        var dot = Path()
                        dot.addEllipse(in: CGRect(
                            x: x - dotRadius,
                            y: y - dotRadius,
                            width: dotRadius * 2,
                            height: dotRadius * 2
                        ))
                        context.fill(dot, with: .color(Color("BrownColor").opacity(0.12 * alpha)))
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ZStack {
        Color("BeigeColor").ignoresSafeArea()
        DotsGridView()
    }
}
