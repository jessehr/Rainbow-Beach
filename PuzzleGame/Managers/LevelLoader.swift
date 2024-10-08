//
//  LevelLoader.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/31/24.
//

import Foundation

class LevelLoader {
    static func load(levelNumber: Int) throws -> Level {
        let rowStrings = try loadFile(for: levelNumber)
        let gamePiece = getGamePiece(from: rowStrings)
        let map = getMap(from: rowStrings)
        return Level(map: map, gamePiece: gamePiece)
    }
    
    private static func getGamePiece(from rowStrings: [String]) -> GamePiece {
        let startIndex = Int(rowStrings.firstIndex(of: "Game-Piece:")!) + 1
        let endIndex = Int(rowStrings.firstIndex(of: "Map:")!)
        let gamePieceStrings = Array(rowStrings[startIndex..<endIndex])
        return GamePiece(from: gamePieceStrings)
    }
    
    private static func getMap(from rowStrings: [String]) -> Map {
        let mapStrings = getMapStrings(from: rowStrings)
        let mapDepths = rowStringsToInts(rowStrings: mapStrings)
        return Map(depths: mapDepths)
    }
    
    private static func getMapStrings(from rowStrings: [String]) -> [String] {
        let startIndex = Int(rowStrings.firstIndex(of: "Map:")!) + 1
        let mapStrings = Array(rowStrings[startIndex...])
        return mapStrings
    }
    
    private static func loadFile(for levelNumber: Int) throws -> [String] {
        guard let path = Bundle.main.path(forResource: "level\(levelNumber)", ofType: "txt") else {
            throw PuzzleError.fileLoadingError
        }
        let fileContents = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        let rowStrings = fileContents.components(separatedBy: .newlines)
        return rowStrings
    }
    
    private static func rowStringsToInts(rowStrings: [String]) -> [[Int]] {
        return rowStrings.map { rowString in
            rowStringToInts(rowString: rowString)
        }
        .filter { !$0.isEmpty }
    }
    
    private static func rowStringToInts(rowString: String) -> [Int] {
        return rowString.map { char in
            #if LEVELBUILDER
            0
            #else
            char.asInt!
            #endif
        }
    }
}
