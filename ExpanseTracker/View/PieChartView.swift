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

    var highestPricedExpenseType: String {
           let groupedExpenses = calculateChartData()
           return groupedExpenses.max(by: { $0.total < $1.total })?.type ?? "No Data"
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
                        Text("Most higest")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        Text(highestPricedExpenseType)
                            .font(.system(size: 23, weight: .bold))
                            .foregroundColor(.primary)
                            .padding(.bottom)
                        Text("Total: $\(totalExpense)")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .padding(.bottom)
                    }
                    .position(x: size.width / 2, y: size.height / 2)
                )


            }
        }
    }
}



