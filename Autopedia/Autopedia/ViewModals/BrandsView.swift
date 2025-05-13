//
//  BrandsView.swift
//  Autopedia
//
//  Created by Hakan Demir on 9.05.2025.
//

import SwiftUI

struct BrandsView: View {
    @State private var selecedBrand: Int? = nil
    @State private var showSheet = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack{
            
            TopNavBar(title: "Sifir Arac")
            
            
            NavigationView{
                ScrollView{
                    LazyVGrid(columns: columns,spacing: 20){
                        ForEach(0..<25) { index in
                            Button( action: {
                                selecedBrand = index
                                showSheet = true
                            }
                                
                            ) {
                                Image(systemName: "car.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .padding()
                                    .background(Color.black)
                                    .cornerRadius(15)
                            }
                        }
                        
                    }
                    .padding(15)
                }
                .sheet(isPresented: $showSheet){
                    if let index = selecedBrand{
                        CarsView(index : index)
                    }
                }
            }
        }
    }
}



