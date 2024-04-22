//
//  TouchPoint.swift
//  PuzzleGame
//
//  Created by Jesse R on 4/20/24.
//

import Foundation

struct TouchPoint: Equatable, Identifiable {
    let creationTime: Date
    let id: UUID
    let startingPoint: CGPoint
    
    var point: CGPoint
    
    init(point: CGPoint) {
        self.id = UUID()
        self.creationTime = Date.now
        self.startingPoint = point
        self.point = point
    }
    
    func degreesRotated(by otherTouchPoint: TouchPoint) -> Double {
        let startingSlope = self.startingPoint.slope(to: otherTouchPoint.startingPoint)
        let currentSlope  = self.point.slope(to: otherTouchPoint.point)

        return 360.0
    }
}
