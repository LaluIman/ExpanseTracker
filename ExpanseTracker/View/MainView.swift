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
                    VStack{
                        if !viewModel.expenses.isEmpty {
                            PieChartView(expenses: viewModel.expenses)
                                .frame(height:310)
                        } else {
                            Circle()
                                .fill(.gray.opacity(0.1))
                                .frame(width: 270, height:270)
                                .overlay{
                                    Text("No expanses yet")
                                        .fontWeight(.bold)
                                }
                        }
                    }
                    .padding()
                    

                    Text("History of Payments 💰")
                        .font(.headline)
                        .padding(.top)

                    
                    Divider()
                    
                    VStack {
                        if !viewModel.expenses.isEmpty{
                            ForEach(viewModel.expenses.indices.reversed(), id: \.self) { index in
                                ExpenseRow(expense: viewModel.expenses[index], deleteAction: {
                                    showAlert = true
                                    deletionIndex = index
                                })
                            }
                        } else {
                            VStack {
                                Text("No payment yet")
                                    .font(.system(size: 20, weight: .semibold))
                            }
                            .frame(height: 300)
                        }
                    }
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
                .navigationBarItems(leading:
                        Text("Expense Tracker")
                    .font(.system(size:25, weight: .bold))
                    .foregroundStyle(.blue)
                )
            }
        }
    }

#Preview {
    MainView()
}
