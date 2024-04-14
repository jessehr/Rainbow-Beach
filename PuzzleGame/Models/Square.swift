//
//  Square.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/24/24.
//

import Foundation
import SwiftUI

struct Square {
    let coords: Coordinates
    let image: Image
    
    var depth: Int
    
    var color: Color {
        let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .black]
        return colors[safe: depth] ?? .black
    }
    
    var canBeFilled: Bool {
        return depth > 0
    }
    
    init(depth: Int, coords: Coordinates) {
        self.depth = depth
        self.coords = coords
        self.image = ImageLoader.image(for: "Square-\(coords.x)-\(coords.y)")
    }
}
