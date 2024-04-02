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
    
    @Published
    var outOfLevels = false
    
    @Published
    private var levelNumber: Int
    
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
    
    init() {
        self.levelNumber = 1
        self.map = try! MapLoader.loadMap(levelNumber: 1)
    }
    
    func dropSand() {
        for sandySquare in sandyCoords {
            map.reduceDepth(at: sandySquare)
        }
        self.baseSandySquareCoords = nil
    }
    
    func incrementLevel() {
        levelNumber += 1
        do {
            self.map = try MapLoader.loadMap(levelNumber: levelNumber)
        } catch {
            outOfLevels = true
        }
    }
    
    func reset() {
        self.map = try! MapLoader.loadMap(levelNumber: levelNumber)
    }
}
