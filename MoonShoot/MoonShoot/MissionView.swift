//
//  MissionView.swift
//  MoonShoot
//
//  Created by Hakan Demir on 27.04.2025.
//

import SwiftUI



struct MissionView: View {
    
    
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        GeometryReader{ geometry in
            ScrollView{
                VStack{
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * (0.6))
                        .padding(.top)
                    

                    
                    VStack(alignment: .leading){
                        Rectangle()
                            .frame(height: 5)
                            .foregroundStyle(.darkBackground)
                            .padding(.vertical)
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Rectangle()
                            .frame(height: 5)
                            .foregroundStyle(.darkBackground)
                            .padding(.vertical)
                        
                        Text(mission.description)
                        
                        
                        Rectangle()
                            .frame(height: 5)
                            .foregroundStyle(.darkBackground)
                            .padding(.vertical)
                        
                        
                        Text("Crew")
                            .font(.title.bold())
                            .foregroundStyle(.secondary)
                            .padding(.bottom, 5)
                        
                        
                    }
                    .padding(.horizontal)
                    
                    
                    
                    Rectangle()
                        .frame(height: 5)
                        .foregroundStyle(.darkBackground)
                        .padding(.vertical)
                    
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(crew, id: \.role) { CrewMember in
                                NavigationLink{
                                    AstronautView(astronaut: CrewMember.astronaut)
                                } label: {
                                    HStack{
                                        Image(CrewMember.astronaut.id)
                                            .resizable()
                                            .frame(width: 104, height: 72)
                                            .clipShape(Capsule())
                                            .overlay(
                                                Capsule()
                                                    .strokeBorder(.white , lineWidth: 1)
                                            )
                                            
                                        VStack(alignment: .leading) {
                                            Text(CrewMember.astronaut.name)
                                                .foregroundColor(.white)
                                                .font(.headline)
                                            Text(CrewMember.role)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
                .padding(.bottom)
            }
            .navigationTitle(mission.DisplayMName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
        }
    }
    init (mission: Mission , astronauts: [String: Astronaut]){
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("We Cannot find \(member.name)")
            }
            
        }
    }
}

struct MissionView_Preview : PreviewProvider {
    
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
