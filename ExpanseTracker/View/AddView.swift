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
    @State private var isFullScreenPresented = false

    var body: some View {
        NavigationView{
            VStack{
                VStack {
                    Text("Add Expanse!")
                        .padding()
                        .font(.title).bold()
                    
                    HStack {
                        HStack{
                            Picker("Select Type:", selection: $selectedType) {
                                ForEach(viewModel.availableTypes, id: \.self) { type in
                                        Text(type)
                                            .tag(type)
                                        .font(.title3).bold()
                                    
                                }
                            }
                            .scaleEffect(1)
                            .pickerStyle(.navigationLink)
                            .padding(.leading, -10)
                        }
                        .padding(.horizontal, 20)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        
                        Button(action: {
                                isFullScreenPresented = true
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title)
                            }
                            .fullScreenCover(isPresented: $isFullScreenPresented) {
                                ExpenseTypeView(viewModel: viewModel)
                            }
                        .padding(.leading)
                    }
                    .padding(.bottom)
                    
                    TextField("how much the price? ($USD)", text: $price)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .keyboardType(.decimalPad)
                    DatePicker("Date you spend on", selection: $date, displayedComponents: .date)
                        .fontWeight(.semibold)
                        .padding()
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
            .navigationBarItems(leading:
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("back")
                    }
                }
            )
        }
    }
}





#Preview {
    AddView(viewModel: ExpenseViewModel())
}
