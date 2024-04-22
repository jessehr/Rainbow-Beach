//
//  CGPointWithID.swift
//  PuzzleGame
//
//  Created by Jesse R on 4/20/24.
//

import Foundation

struct CGPointWithID: Equatable, Identifiable {
    var id = UUID()
    var point: CGPoint
}
