//
//  GameViewModel.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/24/24.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published
    var level: Level
    
    @Published
    var baseGamePieceCoords: Coordinates?
    
    @Published
    var outOfLevels = false
    
    @Published
    private var levelNumber: Int
    
    @Published
    var rotationPosition: RotationPosition = .standard
    
    @Published
    var lastRotationPosition: RotationPosition = .standard

    var gamePiece: GamePiece {
        level.gamePiece
    }
     
    var gamePieceCoords: [Coordinates] {
        guard let baseGamePieceCoords else { return [] }
        return gamePiece.relativePositions.map { relativePosition in
            baseGamePieceCoords.moved(to: relativePosition, with: rotationPosition)
        }
    }
    
    private let soundManager: SoundManager

    init() {
        self.levelNumber = 1
        self.level = try! LevelLoader.load(levelNumber: 1)
        self.soundManager = SoundManager(filename: Constants.dropSoundFilename)
    }
    
    func dropGamePieceSand() throws {
        defer { self.baseGamePieceCoords = nil }
        
        guard gamePieceCanDrop else {
            throw PuzzleError.pieceCannotDrop
        }
        
        soundManager.play(for: Constants.dropAnimationLength)
        
        for gamePieceCoord in gamePieceCoords {
            level.map.reduceDepth(at: gamePieceCoord)
        }
        
        self.baseGamePieceCoords = nil
        #if LEVELBUILDER
        level.map.printMap()
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
