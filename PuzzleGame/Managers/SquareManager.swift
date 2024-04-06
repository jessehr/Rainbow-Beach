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
    var baseGamePieceCoords: Coordinates?
    
    @Published
    var outOfLevels = false
    
    @Published
    private var levelNumber: Int
    
    let gamePieceRelativePositions = [
        RelativePosition(rightward: 0, downward: 0),
        RelativePosition(rightward: 0, downward: 1),
        RelativePosition(rightward: 0, downward: 2),
        RelativePosition(rightward: 1, downward: 2)
    ]
     
    var gamePieceCoords: [Coordinates] {
        guard let baseGamePieceCoords else { return [] }
        return gamePieceRelativePositions.map { relativePosition in
            baseGamePieceCoords.moved(to: relativePosition)
        }
    }
    
    init() {
        self.levelNumber = 1
        self.map = try! MapLoader.loadMap(levelNumber: 1)
    }
    
    func dropSand() throws {
        defer { self.baseGamePieceCoords = nil }
        
        guard allSandCanDrop else {
            throw GeneralError.generalError
        }
        
        for gamePieceCoord in gamePieceCoords {
            map.reduceDepth(at: gamePieceCoord)
        }
        
        self.baseGamePieceCoords = nil
        #if LEVELBUILDER
        map.printMap()
        #endif
    }
    
    var allSandCanDrop: Bool {
        #if LEVELBUILDER
        true
        #else
        gamePieceCoords.allSatisfy({ map.square(at: $0)?.canBeFilled ?? false })
        #endif
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
