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
        // Old line vector from A's startingPoint to B's startingPoint
        let oldVector = CGVector(dx: otherTouchPoint.startingPoint.x - self.startingPoint.x,
                                 dy: otherTouchPoint.startingPoint.y - self.startingPoint.y)
        
        // New line vector from A's current point to B's current point
        let newVector = CGVector(dx: otherTouchPoint.point.x - self.point.x,
                                 dy: otherTouchPoint.point.y - self.point.y)
        
        let dotProduct = oldVector.dx * newVector.dx + oldVector.dy * newVector.dy
        let oldMagnitude = sqrt(oldVector.dx * oldVector.dx + oldVector.dy * oldVector.dy)
        let newMagnitude = sqrt(newVector.dx * newVector.dx + newVector.dy * newVector.dy)
        
        let cosTheta = dotProduct / (oldMagnitude * newMagnitude)
        let angleRadians = acos(min(max(cosTheta, -1.0), 1.0))  // Clamping the cosTheta value to avoid domain error
        
        let crossProduct = oldVector.dx * newVector.dy - oldVector.dy * newVector.dx
        let angleDegrees = angleRadians * 180 / .pi
        return crossProduct >= 0 ? angleDegrees : -angleDegrees  // Positive if counter-clockwise, negative if clockwise
    }
}
