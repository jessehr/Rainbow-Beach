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

enum GeneralError: Error {
    case generalError
}
