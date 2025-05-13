//
//  SwiftUIView.swift
//  Api's VS me
//
//  Created by Hakan Demir on 5.05.2025.
//
import Foundation
import SwiftUI




struct SwiftUIView: View {
    
    
    
    
    
    var body: some View {
        NavigationView {
            NavigationLink("Random Quotes"){
                ForEach(0..<5, id: \.self)
                {_ in
                    Text("123123")
                }
            }
        }
    }
}

#Preview {
    SwiftUIView()
}
