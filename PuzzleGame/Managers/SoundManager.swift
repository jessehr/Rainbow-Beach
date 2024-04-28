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
    private let nPlayers = 100
    
    private let filename: String
    private var players: [AVAudioPlayer]!
    private let soundLength: Double

    init(filename: String, soundLength: Double = Constants.dropAnimationLength) {
        self.filename = filename
        self.soundLength = soundLength
        self.players = []
        fillUpPlayers()
    }
    
    func play() {
        Task {
            let player = players.removeFirst()
            player.play()
            try? await Task.sleep(for: .seconds(soundLength))
            player.pause()
            fillUpPlayers()
        }
    }
    
    private var fileURL: URL? {
        Bundle.main.url(forResource: filename, withExtension: "mp3")
    }
    
    private func makePlayer() -> AVAudioPlayer? {
        guard let fileURL else { return nil }
        let player = try? AVAudioPlayer(contentsOf: fileURL)
        player?.prepareToPlay()
        return player
    }
    
    private func fillUpPlayers() {
        while players.count < nPlayers {
            if let player = makePlayer() {
                players.append(player)
            } else {
                return
            }
        }
        
    }
}
