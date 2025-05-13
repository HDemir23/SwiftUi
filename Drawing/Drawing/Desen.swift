//
//  ContentView.swift
//  Drawing
//
//  Created by Hakan Demir on 28.04.2025.
//

import SwiftUI




struct Desen: View {
    
    struct Flower : Shape {
        let pattleOffset: Double
        let pattleWidth: Double
        
        
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
                let rotation = CGAffineTransform(rotationAngle: number)
                let possition = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
                
                let originalPath = Path(ellipseIn: CGRect(x: pattleOffset, y: 0, width: pattleWidth, height: rect.width / 2))
                
                let rotatedPetal = originalPath.applying(possition)
                
                path.addPath(rotatedPetal)
            }
            
            return path
        }
    }
    
    
    @State private var pattleOffset = -20.0
    @State private var pattleWidth = 100.0

 
    
    var body: some View {
        VStack{
            Flower(pattleOffset: pattleOffset, pattleWidth: pattleWidth)
                .fill(.red, style: FillStyle(eoFill: true))
            
            Text("Offset")
            Slider(value: $pattleOffset, in: -40...40)
                .padding([.horizontal, .bottom])
            
            Text("Width")
            Slider(value: $pattleWidth, in: 0...100)
                .padding([.horizontal, .bottom])
            
        }
      
    }
}

#Preview {
    ContentView()
}
