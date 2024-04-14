//
//  SquareManager.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/24/24.
//

import Foundation

class SquareManager: ObservableObject {
    @Published
    var level: Level
    
    @Published
    var baseGamePieceCoords: Coordinates?
    
    @Published
    var outOfLevels = false
    
    @Published
    private var levelNumber: Int
    
    var gamePiece: GamePiece {
        level.gamePiece
    }
     
    var gamePieceCoords: [Coordinates] {
        guard let baseGamePieceCoords else { return [] }
        return gamePiece.relativePositions.map { relativePosition in
            baseGamePieceCoords.moved(to: relativePosition)
        }
    }
    
    init() {
        self.levelNumber = 1
        self.level = try! LevelLoader.load(levelNumber: 1)
    }
    
    func dropGamePieceSand() throws {
        defer { self.baseGamePieceCoords = nil }
        
        guard gamePieceCanDrop else {
            throw GeneralError.generalError
        }
        
        for gamePieceCoord in gamePieceCoords {
            level.map.reduceDepth(at: gamePieceCoord)
        }
        
        self.baseGamePieceCoords = nil
        #if LEVELBUILDER
        map.printMap()
        #endif
    }
    
    var gamePieceCanDrop: Bool {
        #if LEVELBUILDER
        true
        #else
        gamePieceCoords.allSatisfy({ level.map.square(at: $0)?.canBeFilled ?? false })
        #endif
    }
    
    func incrementLevel() {
        levelNumber += 1
        do {
            self.level = try LevelLoader.load(levelNumber: levelNumber)
        } catch {
            outOfLevels = true
        }
    }
    
    func reset() {
        if let refreshedLevel = try? LevelLoader.load(levelNumber: levelNumber) {
            self.level = refreshedLevel
        }
    }
}
