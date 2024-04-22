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
                
        let cosTheta = newVector.cosTheta(to: oldVector)
        
        let angleRadians = acos(min(max(cosTheta, -1.0), 1.0))  // Clamping the cosTheta value to avoid domain error
        
        let crossProduct = oldVector.dx * newVector.dy - oldVector.dy * newVector.dx
        let angleDegrees = angleRadians * 180 / .pi
        return crossProduct >= 0 ? angleDegrees : -angleDegrees  // Positive if counter-clockwise, negative if clockwise
    }
}
