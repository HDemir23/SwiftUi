//
//  ContentView.swift
//  MoonShoot
//
//  Created by Hakan Demir on 25.04.2025.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let mission: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        
        NavigationView{
                ScrollView{
                    LazyVGrid(columns: columns){
                        ForEach(mission) { mission in
                            NavigationLink{
                                MissionView(mission: mission, astronauts: astronauts)
                            } label: {
                                VStack{
                                    
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .padding()
                                        
                                            
                            
                                    
                                        VStack{
                                            Text(mission.DisplayMName)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            
                                            Text(mission.formattedMissionDate)
                                                .font(.caption)
                                                .foregroundStyle(.white.opacity(0.5))
                                        }
                                        .padding(.vertical)
                                        .frame(maxWidth: .infinity)
                                        .background(.lightBackground)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightBackground)
                                )
                            }
                            
                        }
                    }
                    .padding([.horizontal , .bottom])
                }
                .navigationTitle("Launchs" )
                .preferredColorScheme(.dark)
                .background(.darkBackground)
                
                
        }
    }
}

#Preview {
    ContentView()
}
