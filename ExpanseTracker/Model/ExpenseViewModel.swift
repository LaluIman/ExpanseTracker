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

    func addExpense(type: String, price: Decimal) {
        let newExpense = Expense(type: type, price: price)
        expenses.append(newExpense)
    }

    func removeExpenses(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
    }
}


