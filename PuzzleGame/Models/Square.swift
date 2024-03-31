//
//  Square.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/24/24.
//

import Foundation
import SwiftUI

struct Square {
    var depth: Int
    
    var color: Color {
        let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .black]
        return colors[safe: depth] ?? .black
    }
}
