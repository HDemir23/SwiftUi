//
//  ContentView.swift
//  Hello World
//
//  Created by Hakan Demir on 15.04.2025.
//

import SwiftUI

struct ContentView: View {
    
    
    @State var isTr: Bool = false
    
    
    var body: some View {
        VStack {
            if isTr {
                Text("Merhaba, dünya!")
            }
            else{
                Text("Hello, world!")
             }
            
            
            
            Button (action: {
                self.isTr.toggle()
            },
                    label: {
                Text ("Tap me")
            })
                }
        .font(.title)
        .padding()
    }
}

#Preview {
    ContentView()
}
 
