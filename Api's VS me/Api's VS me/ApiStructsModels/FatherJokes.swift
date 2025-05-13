//
//  FatherJokes.swift
//  Api's VS me
//
//  Created by Hakan Demir on 6.05.2025.
//

import Foundation


struct FatherJokes: Codable {
    let setup: String
    let punchline: String
}


@MainActor

class FatherJokesViewModal: GenericViewModal<FatherJokes> {
    
    init(){
        super.init(endpoint: "https://jokefather.com/api/jokes/random" ,type: FatherJokes.self)
    }
}
