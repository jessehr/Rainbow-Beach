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
    
    func moved(to relativePosition: RelativePosition, with rotationPosition: RotationPosition) -> Coordinates {
        switch rotationPosition {
        case .standard:
            Coordinates(
                x: self.x + relativePosition.rightward,
                y: self.y + relativePosition.downward
            )
        case .clockwise:
            Coordinates(
                x: self.x - relativePosition.downward,
                y: self.y + relativePosition.rightward
            )
        case .upsideDown:
            Coordinates(
                x: self.x - relativePosition.rightward,
                y: self.y - relativePosition.downward
            )
        case .counterClockwise:
            Coordinates(
                x: self.x + relativePosition.downward,
                y: self.y - relativePosition.rightward
            )
        }
    }
}
