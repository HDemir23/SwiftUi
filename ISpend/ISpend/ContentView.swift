//
//  ContentView.swift
//  ISpend
//
//  Created by Hakan Demir on 24.04.2025.
//

import SwiftUI



struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false

    var totalUSD:Double {
        expenses.items
            .filter {$0.currency == "USD"}
            .map(\.amount)
            .reduce(0, +)
    }
    
    var totalTRY:Double {
        expenses.items
            .filter {$0.currency == "TRY"}
            .map(\.amount)
            .reduce(0, +)
    }
    
    var body: some View {
    
        NavigationView{
            VStack{
                
                List{
                    ForEach(expenses.items){ item in
                        HStack{
                            VStack(alignment: .leading) {
                                Text(item.type)
                                    .font(.headline)
                                Text(item.name)
                            }
                            Spacer()
                            VStack{
                                Text(item.amount, format: .currency(code: item.currency))
                                    .font(.caption)
                            }
                            
                        }
                    }
                    .onDelete(perform: removeItems)
                    
                    
                        
                }
                .navigationTitle("ISpend")
                .toolbar{
                    Button {
                        showingAddExpense = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .sheet(isPresented: $showingAddExpense){
                    AddView(expenses: expenses)
                }

                
                VStack(alignment: .leading,spacing: 4){
                    Text("Total USD: \(totalUSD, format: .currency(code: "USD"))")
                    Text("Total TRY: \(totalTRY, format: .currency(code: "TRY"))")
                }
            }
            
            
            

        }
    

    
    }// Ease out //
    

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func calcAmount() {
        
    }


}



struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
