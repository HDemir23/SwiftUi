//
//  ContentView.swift
//  To-Do_App
//
//  Created by Hakan Demir on 29.04.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView{
            NavigationLink(destination: Main_Page())
            {
                ZStack{
                    Circle()
                        .fill(Color.black)
                        .frame(width: 180, height: 180)
                    Image(systemName: "figure.archery")
                        .font(.system(size: 144))
                        .foregroundColor(.white)
                }
            }
            .buttonStyle(PlainButtonStyle())
            .navigationTitle("Welcome")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

#Preview {
    ContentView()
}
