//
//  Extensions.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/22/24.
//

import Foundation
import SwiftUI

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

extension View {
    @ViewBuilder
    func possiblePosition(_ possPosition: CGPoint?) -> some View {
        if let position = possPosition {
            self.position(position)
        } else {
            EmptyView()
        }
    }
    
    func smoothAnimation<V>(value: V, for duration: Double = Constants.dropAnimationLength) -> some View where V : Equatable {
        self.animation(.smooth(duration: duration), value: value)
    }
}

extension Character {
    var asInt: Int? {
        return Int(String(self))
    }
}

enum PuzzleError: Error {
    case fileLoadingError
    case pieceCannotDrop
}

extension Array where Element: Collection, Element.Index == Int {
    func at(_ coords: Coordinates) -> Element.Element {
        return self[coords.y][coords.x]
    }
}
