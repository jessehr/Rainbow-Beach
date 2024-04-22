//
//  TouchHandler.swift
//  PuzzleGame
//
//  Created by Jesse R on 4/20/24.
//

import UIKit
import SwiftUI

struct TouchHandler: UIViewRepresentable {
    @Binding var touchSet: TouchSet

    func makeUIView(context: Context) -> TouchHandlingUIView {
        let view = TouchHandlingUIView()
        view.isMultipleTouchEnabled = true

        view.touchBegan = { touches, event in
            context.coordinator.handleTouches(touches, view: view, event: event)
        }
        view.touchMoved = { touches, event in
            context.coordinator.handleTouches(touches, view: view, event: event)
        }
        view.touchEnded = { touches, event in
            context.coordinator.endTouches(touches)
        }
        view.touchCancelled = { touches, event in
            context.coordinator.endTouches(touches)
        }
        return view
    }

    func updateUIView(_ uiView: TouchHandlingUIView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(touchSet: $touchSet)
    }

    class Coordinator: NSObject {
        var primaryTouch: NSValue?
        var secondaryTouch: NSValue?

        var touchSet: Binding<TouchSet>

        init(touchSet: Binding<TouchSet>) {
            self.touchSet = touchSet
        }

        func handleTouches(_ touches: Set<UITouch>, view: UIView, event: UIEvent?) {
            for touch in touches {
                let location = touch.location(in: view)
                let touchPoint = TouchPoint(id: UUID(), point: location)
                let key = NSValue(nonretainedObject: touch)

                if self.primaryTouch == nil {
                    self.primaryTouch = key
                    self.touchSet.wrappedValue.primary = touchPoint  // Update using wrappedValue
                } else if self.secondaryTouch == nil {
                    self.secondaryTouch = key
                    self.touchSet.wrappedValue.secondary = touchPoint  // Update using wrappedValue
                }
            }
        }

        func endTouches(_ touches: Set<UITouch>) {
            for touch in touches {
                let key = NSValue(nonretainedObject: touch)
                if key == self.primaryTouch {
                    self.primaryTouch = nil
                    self.touchSet.wrappedValue.primary = nil
                    if self.secondaryTouch != nil {
                        self.primaryTouch = self.secondaryTouch
                        self.touchSet.wrappedValue.primary = self.touchSet.wrappedValue.secondary
                        self.secondaryTouch = nil
                        self.touchSet.wrappedValue.secondary = nil
                    }
                } else if key == self.secondaryTouch {
                    self.secondaryTouch = nil
                    self.touchSet.wrappedValue.secondary = nil
                }
            }
        }
    }
}
