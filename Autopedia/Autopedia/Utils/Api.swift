//
//  DocsApi.swift
//  Autopedia
//
//  Created by Hakan Demir on 13.05.2025.
//

import Foundation
// MARK: - Api Service

@MainActor
class ApiService: Codable , ObservableObject {
    func fetch<T: Codable>(from urlString: String, as type: T.Type) async throws -> T {
        
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decode = try JSONDecoder().decode(T.self, from: data)
        
        
        return decode
        
    }
}


// MARK: - Api Model

@MainActor
class ViewModel<R: Codable>: ObservableObject {
    @Published var result: R?
    
    private let endpoint: String
    private let type: R.Type
    private let apiService = ApiService()
    
    init(endpoint: String, type: R.Type){
        self.endpoint = endpoint
        self.type = type
    }
    
    
    func fetchData() async {
        do {
            result = try await apiService.fetch(from: endpoint, as: type)
        } catch {
            if let urlError = error as? URLError, urlError.code == .cancelled {

            } else {
                print("Something went wrong")
            }
        }
    }
    
    
    
    
}

