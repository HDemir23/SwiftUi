//
//  Triangle-Circle.swift
//  Drawing
//
//  Created by Hakan Demir on 28.04.2025.
//

import SwiftUI

struct Triangle_Circle: View {
    
    struct Triangle: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            path.closeSubpath()
            return path
            
            
 
        }
    }
    
    struct Arc : Shape{
        let startAngle: Angle
        let endAngle: Angle
        let clockwise: Bool
    
    
    func path (in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStratPoint = startAngle - rotationAdjustment
        let modifiedEndPoint = endAngle - rotationAdjustment
        
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStratPoint, endAngle: modifiedEndPoint, clockwise: clockwise)
        
        return path
        }
    }
    
    
    var body: some View {
        ZStack{
            Arc(startAngle: .degrees(0), endAngle: .degrees(135 ), clockwise: true)
                .stroke(.primary, lineWidth: 10)
                .frame(width: 300, height: 300)
            Triangle()
                .fill(.secondary)
                .frame(width: 200, height: 200)
                .padding(.bottom ,40)
            
        }
    }
}

#Preview {
    Triangle_Circle()
}
