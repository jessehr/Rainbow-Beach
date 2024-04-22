//
//  TouchPoint.swift
//  PuzzleGame
//
//  Created by Jesse R on 4/20/24.
//

import Foundation

struct TouchPoint: Equatable, Identifiable {
    let creationTime = Date.now
    var id = UUID()
    var point: CGPoint
}
