//
//  Insult.swift
//  Api's VS me
//
//  Created by Hakan Demir on 6.05.2025.
//

import Foundation


struct Insult: Codable {
    let insult: String
    let createdby: String
}

@MainActor
class InsultService:GenericViewModal<Insult> {
    
    init(){
        super.init(endpoint: "https://evilinsult.com/generate_insult.php?lang=en&type=json", type: Insult.self)
    }
}
