//
//  PieChartView.swift
//  ExpanseTracker
//
//  Created by Lalu Iman Abdullah on 22/05/24.
//

import SwiftUI
import Charts

struct PieChartView: View {
    var expenses: [Expense]
        
        var mostCommonExpenseType: String {
            let types = expenses.map { $0.type }
            let typeCounts = types.reduce(into: [:]) { counts, type in
                counts[type, default: 0] += 1
            }
            return typeCounts.max(by: { $0.value < $1.value })?.key ?? "No Data"
        }

        var body: some View {
            Chart {
                ForEach(expenses) { expense in
                    SectorMark(
                        angle: .value("Price", expense.price),
                        outerRadius: .ratio(1.0)
                    )
                    .foregroundStyle(by: .value("Type", expense.type))
                }
            }
            .chartLegend(.visible)
            .chartXAxis(.hidden)
            .chartYAxis(.hidden)
            
            .padding()
        }
}


