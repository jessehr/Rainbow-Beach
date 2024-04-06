//
//  RelativePosition.swift
//  PuzzleGame
//
//  Created by Jesse R on 4/6/24.
//

import Foundation

struct RelativePosition {
    let rightward: Int
    let downward: Int
    
    var asLocalCoords: Coordinates {
        Coordinates(x: rightward, y: downward)
    }
}
