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

    var onChanged: (([CGPoint]) -> Void)?
    var onEnded: (([CGPoint]) -> Void)?

    func makeUIView(context: Context) -> TouchHandlingUIView {
        let view = TouchHandlingUIView()
        view.isMultipleTouchEnabled = true  // Enable multitouch

        view.touchBegan = { touches, event in
            self.handleTouches(touches, view: view, callback: self.onChanged)
        }
        view.touchMoved = { touches, event in
            self.handleTouches(touches, view: view, callback: self.onChanged)
        }
        view.touchEnded = { touches, event in
            self.handleTouches(touches, view: view, callback: self.onEnded)
        }
        view.touchCancelled = { touches, event in
            self.handleTouches(touches, view: view, callback: self.onEnded)
        }
        return view
    }

    func updateUIView(_ uiView: TouchHandlingUIView, context: Context) {}

    private func handleTouches(_ touches: Set<UITouch>, view: UIView, callback: (([CGPoint]) -> Void)?) {
        let locations = touches.map { $0.location(in: view) }
        callback?(locations)
    }

    func onChanged(_ handler: @escaping (([CGPoint]) -> Void)) -> TouchHandler {
        var newView = self
        newView.onChanged = handler
        return newView
    }

    func onEnded(_ handler: @escaping (([CGPoint]) -> Void)) -> TouchHandler {
        var newView = self
        newView.onEnded = handler
        return newView
    }
}
