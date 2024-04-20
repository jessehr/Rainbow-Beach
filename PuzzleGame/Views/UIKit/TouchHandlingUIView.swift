//
//  TouchHandlingUIView.swift
//  PuzzleGame
//
//  Created by Jesse R on 4/20/24.
//

import Foundation

import UIKit

class TouchHandlingUIView: UIView {
    // Closure to send touch events back to SwiftUI
    var touchBegan: ((Set<UITouch>, UIEvent?) -> Void)?
    var touchMoved: ((Set<UITouch>, UIEvent?) -> Void)?
    var touchEnded: ((Set<UITouch>, UIEvent?) -> Void)?

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchBegan?(touches, event)
        super.touchesBegan(touches, with: event)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchMoved?(touches, event)
        super.touchesMoved(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchEnded?(touches, event)
        super.touchesEnded(touches, with: event)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchEnded?(touches, event)
        super.touchesCancelled(touches, with: event)
    }
}
