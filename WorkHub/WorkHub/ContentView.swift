//
//  ContentView.swift
//  WorkHub
//
//  Created by Hakan Demir on 20.04.2025.
//

import SwiftUI



struct ContentView: View {
    
    
    let letters = Array("Hi Theree")
    
    @State private var animationAmount = 0.0
    @State private var enabled = false
    @State private var dragging = CGSize.zero
    
    var body: some View {
        
        
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? Color.green : Color.red)
                    .offset(dragging)
                    .animation(.default(Double(num) / 20),
                               value: dragging
                    )
            }
            
        }
        .gesture(
            DragGesture()
                .onChanged {dragging = $0 .translation}
                .onEnded{ _ in
                    dragging = .zero
                    enabled.toggle()
                }
        )
        
    }
    

}

#Preview {
    ContentView()
}
