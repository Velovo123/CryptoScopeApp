//
//  PortfolioChartView.swift
//  CryptoScope
//
//  Created by Anatolii Semenchuk on 16.04.2026.
//

import SwiftUI
import Charts

struct PortfolioChartView: View {
    let holdings: [Holding]
    let model: PortfolioModel
    
    private var chartData: [(day: Int, value: Double)] {
        guard !holdings.isEmpty else { return [] }
        
        return (0..<30).map { day in
            let factor = 1.0 - Double(29 - day) * 0.002
            let value = holdings.reduce(0.0) { total, holding in
                let currentPrice = model.currentPrice(for: holding.coinId)
                return total + (currentPrice * factor * holding.quantity)
            }
            return (day: day, value: value)
        }
    }
    
    private var minValue: Double {
        chartData.map(\.value).min() ?? 0
    }
    
    private var maxValue: Double {
        chartData.map(\.value).max() ?? 0
    }
    
    var body: some View {
        Chart {
            ForEach(chartData, id: \.day) { point in
                LineMark(
                    x: .value("Day", point.day),
                    y: .value("Value", point.value)
                )
                .foregroundStyle(Color.sage)
                .interpolationMethod(.catmullRom)
                
                AreaMark(
                    x: .value("Day", point.day),
                    yStart: .value("Min", minValue),
                    yEnd: .value("Value", point.value)
                )
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color.sage.opacity(0.3), Color.sage.opacity(0.0)],
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
        .chartYScale(domain: minValue * 0.99 ... maxValue * 1.01)
        .frame(height: 120)
    }
}

#Preview {
    let model = PortfolioModel()
    let holding = Holding(
        coinId: "bitcoin",
        coinName: "Bitcoin",
        coinSymbol: "BTC",
        quantity: 0.5,
        buyPrice: 70000
    )
    PortfolioChartView(holdings: [holding], model: model)
        .padding()
}
