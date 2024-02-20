//
//  Item.swift
//  c
//
//  Created by Dev Prajapati on 19/01/2024.
//

import Foundation
import SwiftData

@Model
final class Game{
    var timestamp: Date
    var name: String
    var moves: String?
    
    
    init(timestamp: Date, name: String) {
        self.timestamp = timestamp
        self.name = name
        self.moves = nil
    }
}
