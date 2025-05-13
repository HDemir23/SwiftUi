//
//  Stoic.swift
//  Api's VS me
//
//  Created by Hakan Demir on 5.05.2025.
//

import Foundation



struct stoicsResponse: Codable , Equatable{
    let data: Stoic
}

struct Stoic: Codable,Equatable {
    let author: String
    let quote: String

}

@MainActor

class StoicViewModel: GenericViewModal<stoicsResponse> {
    
    init(){
        super.init(endpoint: "https://stoic.tekloon.net/stoic-quote", type: stoicsResponse.self)
    }


}
