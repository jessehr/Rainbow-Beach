//
//  SquareManager.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/24/24.
//

import Foundation

class SquareManager: ObservableObject {
    
    @Published
    var squares: [[Square]]
    
    @Published
    var baseSandySquareCoords: Coordinates?
    
    var sandyCoords: [Coordinates] {
        guard let baseSandySquareCoords else { return [] }
        return [
            // FIXME: make this dynamic somehow
            baseSandySquareCoords,
            baseSandySquareCoords.moved(.down),
            baseSandySquareCoords.moved(.down, 2),
            baseSandySquareCoords.moved(.down, 2).moved(.right)
        ]
    }
    
    init(nColumns: Int, nRows: Int) {
        let baseSquare = Square(depth: 0)
        let baseRow = Array(repeating: baseSquare, count: nColumns)
        self.squares = Array(repeating: baseRow, count: nRows)
        self.baseSandySquareCoords = nil
        squares[5][3].depth += 2
        squares[6][3].depth += 2
        squares[7][3].depth += 2
        squares[7][4].depth += 2
        
        squares[4][2].depth += 2
        squares[5][2].depth += 2
        squares[6][2].depth += 2
        squares[6][3].depth += 2
    }
    
    
    func dropSand() {
        for sandySquare in sandyCoords {
            if squares[safe: sandySquare.y]?[safe: sandySquare.x]?.depth ?? -1 > 0 {
                squares[sandySquare.y][sandySquare.x].depth -= 1
            }
        }
        self.baseSandySquareCoords = nil
    }
}
