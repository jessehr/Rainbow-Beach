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
    
    func touching(_ otherCoords: Coordinates) -> Bool {
        return abs(otherCoords.x - x) <= 1 && abs(otherCoords.y - y) <= 1
    }
    
    func coordsBetween(_ otherCoords: Coordinates) -> [Coordinates] {
        let xDiff = otherCoords.x - self.x
        let yDiff = otherCoords.y - self.y
        
        let isSteep = abs(yDiff) > abs(xDiff)
        
        let biggerDiff  = isSteep ? yDiff : xDiff
        let smallerDiff = isSteep ? xDiff : yDiff
        
        return biggerDiff.rangeToZero.map { i in
            singleCoordsBetween(
                position: i,
                isSteep: isSteep,
                biggerDiff: biggerDiff,
                smallerDiff: smallerDiff
            )
        }
    }
    
    private func singleCoordsBetween(
        position i: Int,
        isSteep: Bool,
        biggerDiff: Int,
        smallerDiff: Int
    ) -> Coordinates {
        let fasterAxisStartPosition = isSteep ? self.y : self.x
        let slowerAxisStartPosition = isSteep ? self.x : self.y
        
        let slowerAxisAmountToMove = Double(smallerDiff) / Double(biggerDiff)

        let fasterAxisCurrent = i + fasterAxisStartPosition
        let slowerAxisCurrent = Int(slowerAxisAmountToMove * Double(i)) + slowerAxisStartPosition
        
        let xCurrent = isSteep ? slowerAxisCurrent : fasterAxisCurrent
        let yCurrent = isSteep ? fasterAxisCurrent : slowerAxisCurrent
        
        return Coordinates(x: xCurrent, y: yCurrent)
    }
}
