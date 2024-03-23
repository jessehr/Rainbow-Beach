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
        let xStart = min(self.x, otherCoords.x)
        let xEnd   = max(self.x, otherCoords.x)
        let xDiff = xEnd - xStart
        let yStart = min(self.y, otherCoords.y)
        let yEnd   = max(self.y, otherCoords.y)
        let yDiff = yEnd - yStart
        
        var coordsBetween: [Coordinates] = []
        
        if xDiff > yDiff {
            let yAmountToMove = Double(yDiff) / Double(xDiff)
            for i in 0..<xDiff {
                let currentX = i + xStart
                let currentY = Int(yAmountToMove * Double(i)) + yStart
                coordsBetween.append(Coordinates(x: currentX, y: currentY))
            }
        } else {
            let xAmountToMove = Double(xDiff) / Double(yDiff)
            for i in 0..<yDiff {
                let currentX = Int(xAmountToMove * Double(i)) + xStart
                let currentY = i + yStart
                coordsBetween.append(Coordinates(x: currentX, y: currentY))

            }
        }
        
        return coordsBetween
    }
}
