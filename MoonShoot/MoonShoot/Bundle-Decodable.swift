//
//  Bundle-Decodable.swift
//  MoonShoot
//
//  Created by Hakan Demir on 26.04.2025.
//

import Foundation

extension Bundle {
    func decode<TD: Codable>(_ file: String) -> TD {
        guard let url = self.url(forResource: file, withExtension: nil)
        else{
            fatalError("Failed to locate file in bundle")
        }
        
        guard let data = try? Data(contentsOf: url)
        else{
            fatalError("Failed to load : \(file) from Bunlde ")
        }
        
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(TD.self, from: data) else {
            fatalError("File could not be decoded: \(file )") 
            
        }
        
        return loaded
    }
}
