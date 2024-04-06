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
    
    func moved(to relativePosition: RelativePosition) -> Coordinates {
        Coordinates(
            x: self.x + relativePosition.rightward,
            y: self.y + relativePosition.downward
        )
    }
}
