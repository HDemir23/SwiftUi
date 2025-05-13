//
//  Gasoline.swift
//  Autopedia
//
//  Created by Hakan Demir on 9.05.2025.
//

import SwiftUI

struct Gasoline: View {
    @StateObject private var fetcher = GasPriceFetcher()
    var body: some View {
        VStack(spacing: 0){
            
            TopNavBar(title: "Gasoline")
            if let state = fetcher.state {
            HStack{
                Text("Station")
                Spacer()
                Text("Regular: \(state.gasoline)")
                Spacer()
                Text("MidGrade: \(state.midGrade)")
                Spacer()
                Text("Premium: \(state.premium)")
                }
            .padding(10)
            .font(.title3.bold())
            }
            
            // my opinion is this is an unnecessarry
            NavigationView{
                VStack(alignment: .leading){

                    
                    VStack{
                        ForEach(0..<5 , id: \.self) {index in
                            GasView(title: "", destination: Text("somewher") , destTitle: "")
                        }
                        Spacer()
                    }
                }
                .navigationBarHidden(true)
                .task {
                    await fetcher.fetchGasPrices(for: "WA") // my free trial is ended when i looking here
                }
            }
        }
    }
}



