//
//  SectionView.swift
//  Autopedia
//
//  Created by Hakan Demir on 9.05.2025.
//

import SwiftUI

struct SectionView<Destination: View>: View {
    
    let title: String
    let destination: Destination
    let width: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack{
                Text(title)
                    .font(.title2.bold())
                
                Spacer()
                
                NavigationLink(destination: destination){
                    Text("See All")
                        .foregroundStyle(.blue)
                        .font(.subheadline)
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16){
                    ForEach(0..<10) { index in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray)
                            .frame(width: width,height: 100)
                            .overlay(Text("Car \(index)")
                                .bold()
                                .foregroundStyle(.white)
                            )
                    }
                }
            }
        }
    }
}


