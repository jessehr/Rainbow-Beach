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
    
    var gamePiece: GamePiece {
        map.gamePiece
    }
     
    var gamePieceCoords: [Coordinates] {
        guard let baseGamePieceCoords else { return [] }
        return gamePiece.relativePositions.map { relativePosition in
            baseGamePieceCoords.moved(to: relativePosition)
        }
    }
    
    init() {
        self.levelNumber = 1
        self.map = try! MapLoader.loadMap(levelNumber: 1)
    }
    
    func dropGamePieceSand() throws {
        defer { self.baseGamePieceCoords = nil }
        
        guard gamePieceCanDrop else {
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
    
    var gamePieceCanDrop: Bool {
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
        if let refreshedMap = try? MapLoader.loadMap(levelNumber: levelNumber) {
            self.map = refreshedMap
        }
    }
}
