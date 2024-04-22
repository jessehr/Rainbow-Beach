//
//  TouchHandler.swift
//  PuzzleGame
//
//  Created by Jesse R on 4/20/24.
//

import SwiftUI
import UIKit

struct TouchHandler: UIViewRepresentable {
    @Binding var touchPoints: [TouchPoint]  // Binding to an array of identified points

    func makeUIView(context: Context) -> TouchHandlingUIView {
        let view = TouchHandlingUIView()
        view.isMultipleTouchEnabled = true  // Enable multitouch

        view.touchBegan = { touches, event in
            for touch in touches {
                let key = NSValue(nonretainedObject: touch)
                let newPoint = TouchPoint(point: touch.location(in: view))
                context.coordinator.touchPoints[key] = newPoint
            }
            self.updateBinding(from: context.coordinator.touchPoints)
        }
        view.touchMoved = { touches, event in
            for touch in touches {
                let key = NSValue(nonretainedObject: touch)
                if var existingPoint = context.coordinator.touchPoints[key] {
                    existingPoint.point = touch.location(in: view)
                    context.coordinator.touchPoints[key] = existingPoint
                }
            }
            self.updateBinding(from: context.coordinator.touchPoints)
        }
        view.touchEnded = { touches, event in
            for touch in touches {
                let key = NSValue(nonretainedObject: touch)
                context.coordinator.touchPoints.removeValue(forKey: key)
            }
            self.updateBinding(from: context.coordinator.touchPoints)
        }
        view.touchCancelled = { touches, event in
            for touch in touches {
                let key = NSValue(nonretainedObject: touch)
                context.coordinator.touchPoints.removeValue(forKey: key)
            }
            self.updateBinding(from: context.coordinator.touchPoints)
        }
        return view
    }

    func updateUIView(_ uiView: TouchHandlingUIView, context: Context) { }

    private func updateBinding(from dictionary: [NSValue: TouchPoint]) {
        DispatchQueue.main.async {
            self.touchPoints = Array(dictionary.values)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject {
        var touchPoints = [NSValue: TouchPoint]()  // Dictionary to track points by UITouch
    }
}
