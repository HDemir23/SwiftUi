//
//  ApiDecoder.swift
//  Api's VS me
//
//  Created by Hakan Demir on 5.05.2025.
//
/*
 
 
 */
import Foundation



 // MARK: - Generic Fetch Logic

// T is a placeholder where our struct names go
// urlString is our api


@MainActor
class APIService: Codable , ObservableObject {
    
    func fetch<T: Codable>(from urlString: String, as type: T.Type) async throws -> T {
        
        guard let url = URL(string: urlString) else { throw URLError(.badURL)}
        
        let (data , _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(T.self, from: data)
        
        return decoded
    }
}


// MARK: - Generic view modal Logic

@MainActor
class GenericViewModal<T: Codable>: ObservableObject{
    @Published var result: T?
    
    private let endpint: String
    private let type: T.Type
    private let apiService = APIService()
    
    
    init(endpoint: String, type: T.Type) {
        self.endpint = endpoint
        self.type = type
        
    }
    
    
    func fetchData() async {
        do {
            result = try await apiService.fetch(from: endpint, as: type)
        } catch {
            if let urlError = error as? URLError, urlError.code == .cancelled {
                
            } else {
                print(error)
            }
        }
    }
    
    
}
