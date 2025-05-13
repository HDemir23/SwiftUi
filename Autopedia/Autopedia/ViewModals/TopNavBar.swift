//
//  TopNavBar.swift
//  Autopedia
//
//  Created by Hakan Demir on 9.05.2025.
//

import SwiftUI
    

struct TopNavBar: View {
    let title: String
    
    var body: some View {
        ZStack {
            Color("redbg")
                .ignoresSafeArea(edges: .top)

            Text(title)
                .font(.title.bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
        }
        .frame(height: 60)
        
        
        


    }
}

