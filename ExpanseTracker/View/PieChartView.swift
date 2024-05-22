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
    
    var body: some View {
        Chart {
            ForEach(expenses) { expense in
                SectorMark(
                    angle: .value("Price", expense.price),
                    innerRadius: .ratio(0.5),
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


