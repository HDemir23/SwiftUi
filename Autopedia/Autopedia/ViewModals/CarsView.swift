//
//  CarsView.swift
//  Autopedia
//
//  Created by Hakan Demir on 9.05.2025.
//

import SwiftUI

struct CarsView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    let index : Int
    
    var body: some View {
  
        NavigationView{
            ScrollView{
                LazyVGrid(columns: columns,spacing: 20){
                    ForEach(0..<25) { indexedItem in
                        NavigationLink(destination: Text("somewhere")) {
                            Text("Cars \(indexedItem)")
                        }
                    }

                }
            }
        }
    }
}

