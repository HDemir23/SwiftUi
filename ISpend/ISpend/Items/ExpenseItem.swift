//
//  ExpenseItem.swift
//  ISpend
//
//  Created by Hakan Demir on 24.04.2025.
//

import Foundation


struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    let currency: String
}
