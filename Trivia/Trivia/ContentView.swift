//
//  ContentView.swift
//  Trivia
//
//  Created by Hakan Demir on 30.04.2025.
//

import SwiftUI

struct ContentView: View {
    
    

    
    var body: some View {
        NavigationView{
            NavigationLink(destination: GameOptions()){
                ZStack{
                    Circle()
                        .fill(Color.primary)
                        .frame(width: 200, height: 200)
                    Image(systemName: "figure.skiing.crosscountry")
                        .font(.system(size: 120))
                        .foregroundStyle(.white)
                    
                        
                }
            }
            .buttonStyle(PlainButtonStyle())
            .navigationTitle("Trivia")
            
        }
    }
}

#Preview {
    ContentView()
}
