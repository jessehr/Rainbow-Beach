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

extension Array where Element == TouchPoint {
    private var sortedByAge: [TouchPoint] {
        self.sorted {
            if $0.creationTime != $1.creationTime {
                return $0.creationTime < $1.creationTime
            } else {
                return $0.id.uuidString < $1.id.uuidString
            }
        }
    }
    
    var primaryTouch: TouchPoint? {
        sortedByAge[safe: 0]
    }
    
    var secondaryTouch: TouchPoint? {
        sortedByAge[safe: 1]
    }
}

extension CGPoint {
    func vector(to otherPoint: CGPoint) -> CGVector {
        CGVector(
            dx: otherPoint.x - self.x,
            dy: otherPoint.y - self.y
        )
    }
}

extension CGVector {
    private func cosTheta(to otherVector: CGVector) -> Double {
        let dotProduct = otherVector.dx * self.dx + otherVector.dy * self.dy
        let oldMagnitude = sqrt(otherVector.dx * otherVector.dx + otherVector.dy * otherVector.dy)
        let newMagnitude = sqrt(self.dx * self.dx + self.dy * self.dy)
        let cosTheta = dotProduct / (oldMagnitude * newMagnitude)
        return cosTheta
    }
    
    func angleInDegrees(to otherVector: CGVector) -> Double {
        let cosTheta = self.cosTheta(to: otherVector)
        
        let angleInRadians = acos(min(max(cosTheta, -1.0), 1.0))  // Clamping the cosTheta value to avoid domain error
        let angleInDegrees = angleInRadians * 180 / .pi
        
        return angleInDegrees
    }
    
    func crossProduct(with otherVector: CGVector) -> Double {
        return otherVector.dx * self.dy - otherVector.dy * self.dx
    }
}
