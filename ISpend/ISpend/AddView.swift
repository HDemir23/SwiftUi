//
//  AddView.swift
//  ISpend
//
//  Created by Hakan Demir on 24.04.2025.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    @State private var selectedCurrency = "USD"
    
    let currency = ["USD","TRY"]
    let types = ["Business","Personal","Food","Travel","Other"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name" , text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types ,id: \.self){
                        Text($0)
                    }
                }

                HStack{
                    TextField("amount", value: $amount, format: .currency(code: selectedCurrency))
                        .keyboardType(.decimalPad)
                    
                    
                    
                    Picker("", selection: $selectedCurrency) {
                        ForEach(currency, id: \.self) {
                            currency in
                            Text(currency)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                
                
                .navigationTitle("Add Expense")
                .toolbar{
                    Button("Save") {
                        let item = ExpenseItem(name: name, type: type, amount: amount, currency: selectedCurrency)
                        expenses.items.append(item)
                    }
                }
            }
            
            Text("Hello, World!")
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
