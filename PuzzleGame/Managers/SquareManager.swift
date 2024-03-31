//
//  SquareManager.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/24/24.
//

import Foundation

class SquareManager: ObservableObject {
    @Published
    var map: Map
    
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
    
    init(levelNumber: Int) {
        self.map = MapLoader.loadMap(levelNumber: levelNumber)
        self.baseSandySquareCoords = nil
    }
    
    func dropSand() {
        for sandySquare in sandyCoords {
            map.reduceDepth(at: sandySquare)
        }
        self.baseSandySquareCoords = nil
    }
}
