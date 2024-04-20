//
//  TouchHandler.swift
//  PuzzleGame
//
//  Created by Jesse R on 4/20/24.
//

import SwiftUI

struct TouchHandler: UIViewRepresentable {
    @Binding var touchInfo: String

    func makeUIView(context: Context) -> TouchHandlingUIView {
        let view = TouchHandlingUIView()
        view.touchBegan = { touches, event in
            self.handleTouch("Began", touches: touches)
        }
        view.touchMoved = { touches, event in
            self.handleTouch("Moved", touches: touches)
        }
        view.touchEnded = { touches, event in
            self.handleTouch("Ended", touches: touches)
        }
        return view
    }

    func updateUIView(_ uiView: TouchHandlingUIView, context: Context) {
    }

    private func handleTouch(_ phase: String, touches: Set<UITouch>) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: nil) // Get location relative to the window
        Task { @MainActor in
            self.touchInfo = "\(phase) at \(location)"
        }
    }
}
