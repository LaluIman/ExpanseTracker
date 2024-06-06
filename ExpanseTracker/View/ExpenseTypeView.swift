//
//  ExpenseTypeView.swift
//  ExpanseTracker
//
//  Created by Lalu Iman Abdullah on 06/06/24.
//

import SwiftUI

struct ExpenseTypeView: View {
    @ObservedObject var viewModel: ExpenseViewModel
    @State private var newType: String = ""
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Add New Expense Type")
                .font(.title).bold()
                .padding(.bottom, 20)
            
            TextField("New Type", text: $newType)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(15)
                .padding(.horizontal)

            Button(action: {
                if !newType.isEmpty {
                    viewModel.addNewType(newType)
                    newType = ""
                    presentationMode.wrappedValue.dismiss()
                } else {
                    showAlert = true
                }
            }) {
                Text("Add Type")
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid Input"), message: Text("Please enter a valid type."), dismissButton: .default(Text("OK")))
            }

            Spacer()
        }
        .padding()
    }
}


#Preview {
    ExpenseTypeView(viewModel: ExpenseViewModel())
}
