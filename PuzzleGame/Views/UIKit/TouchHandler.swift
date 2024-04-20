//
//  TouchHandler.swift
//  PuzzleGame
//
//  Created by Jesse R on 4/20/24.
//

import SwiftUI
import UIKit

struct TouchHandler: UIViewRepresentable {
    @Binding var touchInfo: String

    var onChanged: ((CGPoint) -> Void)?
    var onEnded: ((CGPoint) -> Void)?

    func makeUIView(context: Context) -> TouchHandlingUIView {
        let view = TouchHandlingUIView()
        view.touchBegan = { touches, event in
            if let touch = touches.first {
                let location = touch.location(in: view)
                self.onChanged?(location)
            }
        }
        view.touchMoved = { touches, event in
            if let touch = touches.first {
                let location = touch.location(in: view)
                self.onChanged?(location)
            }
        }
        view.touchEnded = { touches, event in
            if let touch = touches.first {
                let location = touch.location(in: view)
                self.onEnded?(location)
            }
        }
        return view
    }

    func updateUIView(_ uiView: TouchHandlingUIView, context: Context) {}

    func onChanged(_ handler: @escaping ((CGPoint) -> Void)) -> TouchHandler {
        var newView = self
        newView.onChanged = handler
        return newView
    }

    func onEnded(_ handler: @escaping ((CGPoint) -> Void)) -> TouchHandler {
        var newView = self
        newView.onEnded = handler
        return newView
    }
}
