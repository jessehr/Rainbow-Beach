//
//  GamePiece.swift
//  PuzzleGame
//
//  Created by Jesse R on 4/7/24.
//

import Foundation

struct GamePiece {
    let relativePositions: [RelativePosition]
    
    init(relativePositions: [RelativePosition]) {
        self.relativePositions = relativePositions
    }
    
    init(from strings: [String]) {
        for row in strings {
            for char in row {
            }
        }
        self.relativePositions = [
            RelativePosition(rightward: 0, downward: 0),
            RelativePosition(rightward: 0, downward: 1),
            RelativePosition(rightward: 0, downward: 2),
            RelativePosition(rightward: 1, downward: 2)
        ]
    }
    
    var normalizedLocalCoords: [Coordinates] {
        let xMin = relativePositions.map { $0.rightward }.min() ?? 0
        let yMin = relativePositions.map { $0.downward }.min() ?? 0
        return relativePositions.map { position in
            Coordinates(
                x: position.rightward - xMin,
                y: position.downward - yMin
            )
        }
    }
    
    var widthInSquares: Int {
        let xValues = normalizedLocalCoords.map { $0.x }
        guard let rightwardMax = xValues.max() else {
            return 0
        }
        return rightwardMax + 1
    }
    
    var heightInSquares: Int {
        let yValues = normalizedLocalCoords.map { $0.y }
        guard let downwardMax = yValues.max() else {
            return 0
        }
        return downwardMax + 1
    }
}
