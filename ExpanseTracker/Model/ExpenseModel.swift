//
//  ExpenseModel.swift
//  ExpanseTracker
//
//  Created by Lalu Iman Abdullah on 22/05/24.
//

import Foundation

struct Expense: Identifiable {
    var id = UUID()
    var type: String
    var price: Decimal
    var date: Date
    
    static func == (lhs: Expense, rhs: Expense) -> Bool {
          return lhs.id == rhs.id
      }
}

