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
    
    init(nColumns: Int, nRows: Int) {
        let baseSquare = Square(depth: 0)
        let baseRow = Array(repeating: baseSquare, count: nColumns)
        self.squares = Array(repeating: baseRow, count: nRows)
    }
    
    func onHover(at coords: Coordinates) {
        disableAllHovering()
        squares[coords.y][coords.x].hasHoveringSand = true
    }
    
    private func disableAllHovering() {
        for rowIndex in squares.indices {
            for columnIndex in squares[rowIndex].indices {
                squares[rowIndex][columnIndex].hasHoveringSand = false
            }
        }
    }
    
    func onRelease(at coords: Coordinates) {
        disableAllHovering()
    }
}
