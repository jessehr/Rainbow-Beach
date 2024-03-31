//
//  Map.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/31/24.
//

import Foundation
import SwiftUI

struct Map {
    var squares: [[Square]]
    
    init(depths: [[Int]]) {
        self.squares = depths.map { $0.map { Square(depth: $0) } }
    }
    
    mutating func reduceDepth(at coords: Coordinates) {
        guard let square = square(at: coords), square.depth > 0 else { return }
        squares[coords.y][coords.x].depth -= 1
    }
    
    func square(at coords: Coordinates) -> Square? {
        squares[safe: coords.y]?[safe: coords.x]
    }
}
