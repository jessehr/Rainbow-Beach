//
//  Coordinates.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/22/24.
//

import Foundation

struct Coordinates: Equatable {
    let x: Int
    let y: Int
    
    func moved(_ direction: Direction, _ amount: Int = 1) -> Coordinates {
        switch direction {
        case .left:
            return Coordinates(x: x - amount, y: y)
        case .right:
            return Coordinates(x: x + amount, y: y)
        case .up:
            return Coordinates(x: x, y: y - amount)
        case .down:
            return Coordinates(x: x, y: y + amount)
        }
    }
}

enum Direction {
    case left
    case right
    case up
    case down
}
