//
//  ContentView.swift
//  test
//
//  Created by Hakan Demir on 15.04.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0
    @State private var People = 2
    @State private var tip = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentage = [10, 15, 20, 25, 0]
    
    var total: Double {
        // ((checkAmount*tip/100) + checkAmount)/People
        let tipValue = Double(checkAmount) * Double(tip) / 100
        let totalValue = (tipValue + Double(checkAmount)) / Double(People + 2)
        return totalValue
    }
    
    var body: some View {
        
        NavigationView{
            Form {
                Section{
                    TextField("Amount" , value: $checkAmount, format:
                            .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                
                } header: {
                    Text("How much ?")
                }
                
                Section{
                    Picker("Number of people", selection: $People) {
                        ForEach(2..<50){
                            Text("\($0) people")
                        }
                    }
                }
                
                Section{
                    Picker("Tip", selection: $tip) {
                        ForEach(tipPercentage, id: \.self){
                            Text($0 , format: .percent)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                } header: {
                    Text("How much Tip would you like to give?")
                }
                
                
                
                Section {
                    Text( total, format:
                            .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Payout per person")
                }
            }
            .navigationTitle("Hwo Pays").navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {

                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
        

        
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
