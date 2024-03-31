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
    private var player: AVAudioPlayer!
    private var stopTimer: Timer?
    private var timeManager: TimeManager
    
    init(filename: String, fileType: String = "mp3") {
        self.filename = filename
        self.fileType = fileType
        self.timeManager = TimeManager()
        self.player = nil
        
        // now that everything is initialized, use instance vars
        self.timeManager.callback = self.pause
        self.player = makePlayer(filename: filename, fileType: fileType)
    }
    
    func play(for durationInSeconds: TimeInterval) {
        if !player.isPlaying {
            player.play()
        }
        timeManager.setOrResetTimer(for: durationInSeconds)
    }
            
    private func play() {
        player.play()
    }
    
    private func pause() {
        player.pause()
        player.currentTime = 0
    }
    
    private func makePlayer(filename: String, fileType: String) -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: fileType) else { return nil }
        let player = try? AVAudioPlayer(contentsOf: url)
        player?.prepareToPlay()
        return player
    }
}
