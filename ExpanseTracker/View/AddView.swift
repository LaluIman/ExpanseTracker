//
//  AddView.swift
//  ExpanseTracker
//
//  Created by Lalu Iman Abdullah on 22/05/24.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var viewModel: ExpenseViewModel
    @State private var selectedType: String = ""
    @State private var newType: String = ""
    @State private var price = ""
    @State private var date = Date()
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack{
            VStack {
                Text("Add Expanse!")
                    .padding()
                    .font(.title).bold()
                
                Section(header: Text("Type of Payment").font(.title3).fontWeight(.bold)) {
                    VStack {
                        Picker("Select Type", selection: $selectedType) {
                               ForEach(viewModel.availableTypes, id: \.self) { type in
                                   Text(type).tag(type)
                               }
                        }
                    }
                   }
                TextField("how much the price? {$}", text: $price)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .keyboardType(.decimalPad)
                DatePicker("Date you spend on", selection: $date, displayedComponents: .date)
            }
            .padding()
            .textFieldStyle(PlainTextFieldStyle())
            Button(action: {
                if let priceValue = Decimal(string: price) {
                    viewModel.addExpense(type: selectedType, price: priceValue, date: date)
                    selectedType = ""
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
        .padding()
                .navigationBarItems(trailing: NavigationLink(destination: ExpenseTypeView(viewModel: viewModel)) {
                    Image(systemName: "plus")
                })
    }
}





#Preview {
    AddView(viewModel: ExpenseViewModel())
}
