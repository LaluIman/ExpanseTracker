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
    @State private var showDeleteAlert = false
    @State private var typeToDelete: String?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView{
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
                
                VStack{
                    Text("Current type")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    List {
                        ForEach(viewModel.availableTypes, id: \.self) { type in
                            HStack {
                                Text(type)
                                Spacer()
                                Button(action: {
                                    typeToDelete = type
                                    showDeleteAlert = true
                                }) {
                                    Image(systemName: "trash.fill")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .scrollDisabled(true)
                    .alert(isPresented: $showDeleteAlert) {
                        Alert(
                            title: Text("Confirm Deletion"),
                            message: Text("Are you sure you want to delete this expense type?"),
                            primaryButton: .destructive(Text("Delete")) {
                                if let typeToDelete = typeToDelete {
                                    viewModel.deleteType(typeToDelete)
                                }
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
            }
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
    ExpenseTypeView(viewModel: ExpenseViewModel())
}
