//
//  RotationPosition.swift
//  PuzzleGame
//
//  Created by Jesse R on 4/26/24.
//

import Foundation

enum RotationPosition: Double, CaseIterable {
    case standard = 0
    case clockwise = 90
    case upsideDown = 180
    case counterClockwise = 270
    
    static func positionClosest(to angle: Double) -> RotationPosition {
        for position in RotationPosition.allCases {
            if position.isCloseTo(angle, within: 45.0) {
                return position
            }
        }
        return .standard
    }
    
    static func positionVeryClose(to angle: Double) -> RotationPosition? {
        for position in RotationPosition.allCases {
            if position.isCloseTo(angle, within: 10.0) {
                return position
            }
        }
        return nil
    }
    
    private func isCloseTo(_ rotationInDegrees: Double, within nearbyDistance: Double) -> Bool {
        guard self != .standard else {
            return rotationInDegrees < nearbyDistance || rotationInDegrees > 360 - nearbyDistance
        }
        return abs(self.rawValue - rotationInDegrees) < nearbyDistance
    }
}
