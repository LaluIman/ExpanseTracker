//
//  ExpenseRow.swift
//  ExpanseTracker
//
//  Created by Lalu Iman Abdullah on 23/05/24.
//

import SwiftUI

struct ExpenseRow: View {
    let expense: Expense
       let deleteAction: () -> Void

       var body: some View {
           VStack(alignment: .leading, spacing: 4) {
               Text(expense.type)
                   .font(.system(size: 20, weight: .bold))
               HStack {
                   Text("\(expense.price, format: .currency(code: "USD"))")
                   Spacer()
                   HStack{
                       Text(expense.date, style: .date)
                           .font(.subheadline)
                           .foregroundColor(.gray)
                       Button(action: deleteAction) {
                           Image(systemName: "trash.fill")
                               .foregroundColor(.red)
                               .padding(5)
                       }
                   }
               }
               
           }
           .padding()
           .background(Color(.secondarySystemBackground))
           .cornerRadius(20)
           .padding(.horizontal)
       }
}



