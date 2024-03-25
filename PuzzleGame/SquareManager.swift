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
    var sandyCoords: Coordinates?
    
    init(nColumns: Int, nRows: Int) {
        let baseSquare = Square(depth: 0)
        let baseRow = Array(repeating: baseSquare, count: nColumns)
        self.squares = Array(repeating: baseRow, count: nRows)
        self.sandyCoords = nil
    }
}
