//
//  AstronautView.swift
//  MoonShoot
//
//  Created by Hakan Demir on 27.04.2025.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut : Astronaut
    var body: some View {
        ScrollView{
            VStack{
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .cornerRadius(80)
                
                Text(astronaut.description)
                    .padding()
                    
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}




struct AstronautView_Preview : PreviewProvider {
    
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts["armstrong"]!)
            .preferredColorScheme(.dark)
    }
}
