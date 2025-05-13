//
//  Tasks.swift
//  To-Do_App
//
//  Created by Hakan Demir on 29.04.2025.
//

import Foundation

struct Task: Identifiable{
    var id = UUID()
    var title: String
    var isDone: Bool = false
}



