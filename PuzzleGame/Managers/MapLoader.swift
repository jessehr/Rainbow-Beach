//
//  MapLoader.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/31/24.
//

import Foundation

class MapLoader {
    static func loadMap(levelNumber: Int) throws -> Map {
        let rowStrings = try getRowStrings(for: levelNumber)
        let dividerIndex = Int(rowStrings.firstIndex(of: "Map:")!)
        let mapStrings = Array(rowStrings[(dividerIndex + 1)...])
        let mapDepths = rowStringsToInts(rowStrings: mapStrings)
        let gamePiece = getGamePiece(from: rowStrings)
        return Map(depths: mapDepths, gamePiece: gamePiece)
    }
    
    private static func getGamePiece(from rowStrings: [String]) -> GamePiece {
        let startIndex = Int(rowStrings.firstIndex(of: "Game-Piece:")!) + 1
        let endIndex = Int(rowStrings.firstIndex(of: "Map:")!)
        let gamePieceStrings = Array(rowStrings[startIndex..<endIndex])
        return GamePiece(from: gamePieceStrings)
    }
    
    private static func getRowStrings(for levelNumber: Int) throws -> [String] {
        guard let path = Bundle.main.path(forResource: "level\(levelNumber)", ofType: "txt") else {
            throw GeneralError.generalError
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
