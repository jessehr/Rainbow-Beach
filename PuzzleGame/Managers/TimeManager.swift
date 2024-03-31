//
//  TimeManager.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/31/24.
//

import Foundation

class TimeManager {
    private var timer: Timer?
    var callback: (() -> Void)?
    
    func setOrResetTimer(for durationInSeconds: TimeInterval) {
        if timer == nil {
            setTimer(for: durationInSeconds)
        } else {
            resetTimer(for: durationInSeconds)
        }
    }
        
    private func resetTimer(for durationInSeconds: TimeInterval) {
        timer?.invalidate()
        timer = makeTimer(for: durationInSeconds)
    }
    
    private func setTimer(for durationInSeconds: TimeInterval) {
        timer = makeTimer(for: durationInSeconds)
    }
    
    private func makeTimer(for durationInSeconds: TimeInterval) -> Timer {
        return Timer.scheduledTimer(withTimeInterval: durationInSeconds, repeats: false) { _ in
            if let callback = self.callback {
                callback()
            }
        }
    }
}
