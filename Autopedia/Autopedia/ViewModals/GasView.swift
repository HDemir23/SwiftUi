//
//  GasView.swift
//  Autopedia
//
//  Created by Hakan Demir on 9.05.2025.
//

import SwiftUI

struct GasView<Destination: View>: View {
    
    
    
    let title: String
    let destination: Destination
    let destTitle: String
    
    struct Prices: View {
        let subTitle: String
        
        
        
        
        var body: some View {
            VStack{
                Text(subTitle)
                    .font(.headline)
                Text("some")
            }
        }
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            
            HStack{
                Text(title)
                    .font(.title2.bold())
                Spacer()
                
                NavigationLink(destination: destination){
                    Text(destTitle)
                        .foregroundStyle(.blue)
                        .font(.subheadline)
                    
                }
            }
            
            HStack{
                Image(systemName: "car")
                Spacer()
                Prices(subTitle: "Benzin")
                Spacer()
                Prices(subTitle: "Dizel" )
                Spacer()
                Prices(subTitle: "LPG")
            }
            .padding(.horizontal)
            .background(Color("WhiteGray"))
            .cornerRadius(15)
            
        }
        
        
        
        
    }
    
    
}
