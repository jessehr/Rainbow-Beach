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
        let oldVector = self.startingPoint.vector(to: otherTouchPoint.startingPoint)
        let newVector = self.point.vector(to: otherTouchPoint.point)
        
        let angleInDegrees = newVector.angleInDegrees(to: oldVector)
        let crossProduct = newVector.crossProduct(with: oldVector)
        
        return crossProduct >= 0 ? angleInDegrees : -angleInDegrees  // Positive if counter-clockwise, negative if clockwise
    }
}
