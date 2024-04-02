//
//  MapLoader.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/31/24.
//

import Foundation

class MapLoader {
    static func loadMap(levelNumber: Int) throws -> Map {
        guard let path = Bundle.main.path(forResource: "level\(levelNumber)", ofType: "txt") else {
            throw GeneralError.generalError
        }
        let fileContents = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
        let rowStrings = fileContents.components(separatedBy: .newlines)
        let depths = rowStringsToInts(rowStrings: rowStrings)
        return Map(depths: depths)
    }
    
    private static func rowStringsToInts(rowStrings: [String]) -> [[Int]] {
        return rowStrings.map { rowString in
            rowStringToInts(rowString: rowString)
        }
        .filter { !$0.isEmpty }
    }
    
    private static func rowStringToInts(rowString: String) -> [Int] {
        return rowString.map { char in
            char.asInt!
        }
    }
}
