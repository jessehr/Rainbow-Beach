//
//  SoundManager.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/29/24.
//

import Foundation
import AVFoundation
import UIKit

class SoundManager {
    private let filename: String
    private let fileType: String
    private var player: AVAudioPlayer?
    private var isPlaying = false
    private var stopTimer: Timer?
    
    private static func getPreparedPlayer(filename: String, fileType: String) -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: fileType) else { return nil }
        let player = try? AVAudioPlayer(contentsOf: url)
        player?.prepareToPlay()
        return player
    }
    
    init(filename: String, fileType: String = "mp3") {
        self.player = Self.getPreparedPlayer(filename: filename, fileType: fileType)
        self.filename = filename
        self.fileType = fileType
    }
    
    func play(for durationInSeconds: TimeInterval, reset: Bool = true) {
        if isPlaying {
            extendPlayTime(for: durationInSeconds)
        } else {
            playFromStart(for: durationInSeconds)
        }
    }
    
    private func extendPlayTime(for durationInSeconds: TimeInterval) {
        self.stopTimer?.invalidate()
        self.stopTimer = makeStopTimer(for: durationInSeconds)
    }
    
    private func playFromStart(for durationInSeconds: TimeInterval) {
        play()
        self.stopTimer = makeStopTimer(for: durationInSeconds)
    }
    
    private func play() {
        isPlaying = true
        player?.play()
    }
    
    private func pause() {
        player?.pause()
        player?.currentTime = 0
        isPlaying = false
    }
    
    private func makeStopTimer(for durationInSeconds: TimeInterval) -> Timer {
        return Timer.scheduledTimer(withTimeInterval: durationInSeconds, repeats: false) { _ in
            self.pause()
        }
    }
}
