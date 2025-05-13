//
//  Mission.swift
//  MoonShoot
//
//  Created by Hakan Demir on 26.04.2025.
//

import Foundation


struct Mission: Codable, Identifiable {
    
        struct CrewRole: Codable {
            var name: String
            var role: String
        }
    
    var id: Int
    var launchDate: Date?
    var crew: [CrewRole]
    var description: String
    
    
    
    var DisplayMName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedMissionDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted ) ?? "N/A"
    }
}
