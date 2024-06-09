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

    // Function to group expenses by type and calculate total price for each type
    private func calculateChartData() -> [(type: String, total: Decimal)] {
        var typeTotal: [String: Decimal] = [:]

        for expense in expenses {
            let type = expense.type.capitalized
            typeTotal[type, default: 0] += expense.price
        }

        return typeTotal.map { (type: $0.key, total: $0.value) }
    }

    var totalExpense: Decimal {
        return expenses.reduce(0) { $0 + $1.price }
    }

    var mostCommonExpenseType: String {
        let types = expenses.map { $0.type.capitalized }
        let typeCounts = types.reduce(into: [:]) { counts, type in
            counts[type, default: 0] += 1
        }
        return typeCounts.max(by: { $0.value < $1.value })?.key ?? "No Data"
    }

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            VStack {
                Chart {
                    ForEach(calculateChartData(), id: \.type) { expense in
                        SectorMark(
                            angle: .value("Price", expense.total),
                            innerRadius: .ratio(0.6),
                            outerRadius: .ratio(1.0),
                            angularInset: 1.5
                        )
                        .cornerRadius(5)
                        .foregroundStyle(by: .value("Type", expense.type))
                    }
                }
                .chartLegend(.visible)
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
                .padding()
                .overlay(
                    VStack {
                        Text("Most spend")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        Text(mostCommonExpenseType)
                            .font(.headline.bold())
                            .foregroundColor(.primary)
                            .padding(.bottom)
                        Text("Total: $ \(totalExpense)")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                            .padding(.bottom)
                    }
                    .position(x: size.width / 2, y: size.height / 2)
                )


            }
        }
    }
}



