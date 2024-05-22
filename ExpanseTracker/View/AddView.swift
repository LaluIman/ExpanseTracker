//
//  AddView.swift
//  ExpanseTracker
//
//  Created by Lalu Iman Abdullah on 22/05/24.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var viewModel: ExpenseViewModel
    @State private var type = ""
    @State private var price = ""
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack{
            VStack {
                Text("Add Expanse!")
                    .padding()
                    .font(.title).bold()
                
                TextField("what did you spend on?", text: $type)
                    .padding()
                    .background(.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                TextField("how much the price?", text: $price)
                    .padding()
                    .background(.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .keyboardType(.decimalPad)
            }
            .padding()
            .textFieldStyle(PlainTextFieldStyle())
            Button(action: {
                if let priceValue = Decimal(string: price) {
                    viewModel.addExpense(type: type, price: priceValue)
                    type = ""
                    price = ""
                    
                    presentationMode.wrappedValue.dismiss()
                } else {
                    
                    showAlert = true
                }
            }) {
                Text("Add Expense")
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid Input"), message: Text("Please enter a valid number for the price."), dismissButton: .default(Text("OK")))
            }
        }
        .frame(height: 700, alignment: .top)
    }
}





#Preview {
    AddView(viewModel: ExpenseViewModel())
}
