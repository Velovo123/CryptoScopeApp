//
//  PriceChartView.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 16.04.2026.
//

import SwiftUI
import Charts

struct PriceChartView: View {
    let priceHistory: [PricePoint]
    
    private var isPositive: Bool {
        guard let first = priceHistory.first, let last = priceHistory.last else { return true }
        return last.price >= first.price
    }
    
    private var color: Color {
        isPositive ? .priceUp : .priceDown
    }
    
    private var minPrice: Double {
        priceHistory.map(\.price).min() ?? 0
    }
    
    private var maxPrice: Double {
        priceHistory.map(\.price).max() ?? 0
    }
    
    var body: some View {
        Chart {
            ForEach(priceHistory) { point in
                LineMark(
                    x: .value("Date", point.date),
                    y: .value("Price", point.price)
                )
                .foregroundStyle(color)
                .interpolationMethod(.catmullRom)
                
                AreaMark(
                    x: .value("Date", point.date),
                    yStart: .value("Min", minPrice),
                    yEnd: .value("Price", point.price)
                )
                .foregroundStyle(
                    LinearGradient(
                        colors: [color.opacity(0.3), color.opacity(0.0)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .interpolationMethod(.catmullRom)
            }
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .chartLegend(.hidden)
        .chartYScale(domain: minPrice * 0.99 ... maxPrice * 1.01)
        .frame(height: 200)
    }
}

#Preview {
    PriceChartView(priceHistory: MockData.priceHistory)
        .padding()
}
