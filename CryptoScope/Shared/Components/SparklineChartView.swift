//
//  SparklineChartView.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 15.04.2026.
//


import SwiftUI
import Charts

struct SparklineChartView: View {
    let prices: [Double]
    
    private var isPositive: Bool {
        guard let first = prices.first, let last = prices.last else { return true }
        return last >= first
    }
    
    private var color: Color {
        isPositive ? .priceUp : .priceDown
    }
    
    var body: some View {
        Chart {
            ForEach(Array(prices.enumerated()), id: \.offset) { index, price in
                LineMark(
                    x: .value("Index", index),
                    y: .value("Price", price)
                )
                .foregroundStyle(color)
                .interpolationMethod(.catmullRom)
            }
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .chartLegend(.hidden)
        .frame(width: 60, height: 30)
    }
}

#Preview {
    HStack {
        SparklineChartView(prices: [100, 120, 110, 130, 125, 140, 135])
        SparklineChartView(prices: [140, 135, 125, 130, 110, 120, 100])
    }
    .padding()
}
