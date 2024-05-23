//
//  MainView.swift
//  ExpanseTracker
//
//  Created by Lalu Iman Abdullah on 22/05/24.
//

import SwiftUI

    struct MainView: View {
        @StateObject var viewModel = ExpenseViewModel()
        @State private var showAlert = false
        @State private var deletionIndex: Int?

        var body: some View {
            NavigationView {
                ScrollView {
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

                        VStack {
                            ForEach(viewModel.expenses.indices.reversed(), id: \.self) { index in
                                        ExpenseRow(expense: viewModel.expenses[index], deleteAction: {
                                            showAlert = true
                                            deletionIndex = index
                                        })
                                    }                        }
                    }
                }
                .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text("Confirm Deletion"),
                                    message: Text("Are you sure you want to delete this expense?"),
                                    primaryButton: .destructive(Text("Delete")) {
                                        if let index = deletionIndex {
                                            viewModel.deleteExpense(at: index)
                                        }
                                    },
                                    secondaryButton: .cancel()
                                )
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
