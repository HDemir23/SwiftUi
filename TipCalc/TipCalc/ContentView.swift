//
//  ContentView.swift
//  TipCalc
//
//  Created by Hakan Demir on 22.04.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var people = 2
    @State private var  total: Double = 0
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool
    
    let tips = [0, 10, 15 , 20 ,25]
    
    @State private var totalAmount = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section{
                    TextField("Amount", value: $total , format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                } header: {
                   Text( "Whatsuppp")
                }
                
                
                Section{
                    Picker("asd", selection: $people){
                        ForEach(1..<20){
                            Text("\($0) people")
                        }
                    }
                } header: {
                    Text("Percentage")
                }
                
                
                
                Section{
                    Picker("asdas" , selection: $tipPercentage){
                        ForEach(tips, id: \.self){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                
                Section{
                    Text("Final amount Per Person = \(calculateTip)")
                }
            }
            .navigationTitle("Tip Caclulator").navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    
                    Button("OK") {
                        amountIsFocused = false
                    }
                    Spacer()
                }
            }
        }
        
    }
    
    
    
    
    
    
    
    var calculateTip:Double {
        let tip = total * Double(tipPercentage)/100
        let totalWithTip = (Double(total) + tip) / Double(people + 1)
        return totalWithTip
        
        
    }
}

#Preview {
    ContentView()
}
