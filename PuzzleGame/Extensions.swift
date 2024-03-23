//
//  Extensions.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/22/24.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Int {
    var rangeToZero: Range<Int> {
        if self >= 0 {
            return 0..<self
        } else {
            return self..<0
        }
    }
}
