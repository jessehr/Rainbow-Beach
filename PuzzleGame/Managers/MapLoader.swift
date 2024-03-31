//
//  MapLoader.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/31/24.
//

import Foundation

class MapLoader {
    static func loadMap(levelNumber: Int) -> Map {
        let path = Bundle.main.path(forResource: "level\(levelNumber)", ofType: "txt")!
        let fileContents = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
        let rowStrings = fileContents.components(separatedBy: .newlines)
        var depths = rowStringsToInts(rowStrings: rowStrings)
        return Map(depths: depths)
    }
    
    private static func rowStringsToInts(rowStrings: [String]) -> [[Int]] {
        return rowStrings.map { rowString in
            rowStringToInts(rowString: rowString)
        }
    }
    
    private static func rowStringToInts(rowString: String) -> [Int] {
        return rowString.map { char in
            char.asInt!
        }
    }
}
