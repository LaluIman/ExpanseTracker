//
//  ExpenseViewModel.swift
//  ExpanseTracker
//
//  Created by Lalu Iman Abdullah on 22/05/24.
//

import SwiftUI
import Combine

class ExpenseViewModel: ObservableObject {
    @Published var expenses: [Expense] = []

    func addExpense(type: String, price: Decimal, date: Date) {
        let newExpense = Expense(type: type, price: price, date: date)
        expenses.append(newExpense)
    }

    func removeExpenses(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
    }
    
    func deleteExpense(at index: Int) {
            expenses.remove(at: index)
        }
    
    var mostCommonExpenseType: String {
            let types = expenses.map { $0.type }
            let typeCounts = types.reduce(into: [:]) { counts, type in
                counts[type, default: 0] += 1
            }
            return typeCounts.max(by: { $0.value < $1.value })?.key ?? "No Data"
        }
}


