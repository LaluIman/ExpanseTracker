//
//  MainView.swift
//  ExpanseTracker
//
//  Created by Lalu Iman Abdullah on 22/05/24.
//

import SwiftUI

    struct MainView: View {
        @StateObject var viewModel = ExpenseViewModel()

        var body: some View {
            NavigationView {
                VStack {
                    Text("My Expense")
                        .font(.largeTitle).bold()
                        .padding()

                    if !viewModel.expenses.isEmpty {
                        PieChartView(expenses: viewModel.expenses)
                            .frame(height: 300)
                    } else {
                        Circle()
                            .fill(.gray.opacity(0.1))
                            .frame(width: 270, height:270)
                            .overlay{
                                Text("No expanses yet")
                                    .fontWeight(.bold)
                            }
                    }

                    Text("History of Payments 💰")
                        .font(.headline)
                        .padding(.top)

                    List {
                        ForEach(viewModel.expenses) { expense in
                            HStack {
                                Text(expense.type)
                                Spacer()
                                Text("\(expense.price, format: .currency(code: "USD"))")
                            }
                        }
                        .onDelete(perform: viewModel.removeExpenses)
                    }
                }
                .navigationBarItems(trailing: NavigationLink(destination: AddView(viewModel: viewModel)) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                    
                })
            }
        }
    }

#Preview {
    MainView()
}
