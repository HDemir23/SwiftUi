//
//  Home.swift
//  Autopedia
//
//  Created by Hakan Demir on 9.05.2025.
//

import SwiftUI

struct Home: View {
    var body: some View {
        
        VStack(spacing: 0){
            TopNavBar(title: "Autopedia")
        
        
        ScrollView{
            VStack(alignment: .leading, spacing: 20){
                
                // MARK: - Gas Things
                GasView(title: "Gas Prices", destination: Text("Some Dest"), destTitle: "See All")
                // MARK: - Gas Things
                SectionView(title: "Mikro Info's", destination: Text("Dest"), width: 100)
                // MARK: - Gas Things
                SectionView(title: "Connection", destination: Text("Dest"), width: 150)
                // MARK: - Gas Things
                SectionView(title: "Additional", destination: Text("Dest"), width: 175)
            }
            .padding(.horizontal, 16)
            .padding(.top, 40)
            
            }
   
        }
    }
}


