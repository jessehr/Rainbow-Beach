//
//  OperatorOverloading.swift
//  PuzzleGame
//
//  Created by Jesse R on 4/7/24.
//

import Foundation

extension CGFloat {
    static func + (left: CGFloat, right: Int) -> CGFloat {
        return left + CGFloat(right)
    }
    
    static func - (left: CGFloat, right: Int) -> CGFloat {
        return left - CGFloat(right)
    }
    
    static func * (left: CGFloat, right: Int) -> CGFloat {
        return left * CGFloat(right)
    }
    
    static func / (left: CGFloat, right: Int) -> CGFloat {
        return left / CGFloat(right)
    }
}

extension Int {
    static func + (left: Int, right: CGFloat) -> CGFloat {
        return CGFloat(left) + right
    }
    
    static func - (left: Int, right: CGFloat) -> CGFloat {
        return CGFloat(left) - right
    }
    
    static func * (left: Int, right: CGFloat) -> CGFloat {
        return CGFloat(left) * right
    }

    static func / (left: Int, right: CGFloat) -> CGFloat {
        return CGFloat(left) / right
    }
}
