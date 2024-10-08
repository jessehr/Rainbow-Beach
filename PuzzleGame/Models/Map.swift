//
//  Map.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/31/24.
//

import Foundation
import SwiftUI

struct Map {
    var squares: [[Square]]
    
    init(depths: [[Int]]) {
        self.squares = depths.indices.map { rowIndex in
            depths[rowIndex].indices.map { columnIndex in
                let coords = Coordinates(x: columnIndex, y: rowIndex)
                return Square(
                    depth: depths.at(coords),
                    coords: coords
                )
            }
        }
    }
    
    mutating func reduceDepth(at coords: Coordinates) {
        guard let square = square(at: coords) else { return }
        #if LEVELBUILDER
        squares[coords.y][coords.x].depth += 1
        #else
        guard square.depth > 0 else { return }
        squares[coords.y][coords.x].depth -= 1
        #endif
    }
    
    func square(at coords: Coordinates) -> Square? {
        squares[safe: coords.y]?[safe: coords.x]
    }
    
    var isSolved: Bool {
        let isNotSolved = squares.contains { row in
            row.contains { $0.depth != 0 }
        }
        return !isNotSolved
    }
    
    #if LEVELBUILDER
    func printMap() {
        print()
        for row in squares {
            for square in row {
                print("\(square.depth)", terminator: "")
            }
            print()
        }
        print()
    }
    #endif
}
