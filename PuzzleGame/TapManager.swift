//
//  TapManager.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/23/24.
//

import Foundation

class TapManager: ObservableObject {
    @Published
    var taps: [[Int]]
    
    @Published
    var tapsAddedThisRound: [Coordinates] = []

    init(nColumns: Int, nRows: Int) {
        let sampleRow = Array(repeating: 0, count: nColumns)
        self.taps = Array(repeating: sampleRow, count: nRows)
        self.tapsAddedThisRound = []
    }

    func onTap(at coords: Coordinates) {
        addMissingTaps(near: coords)
        incrementTapCount(at: coords)
    }
    
    func endRound() {
        tapsAddedThisRound = []
    }
    
    private func addMissingTaps(near coords: Coordinates) {
        guard
            let lastTap = tapsAddedThisRound.last,
            !lastTap.touching(coords) else {
            return
        }
        
        let tapsBetween = coords.coordsBetween(lastTap)
        for tap in tapsBetween where !tapsAddedThisRound.contains(tap) {
            incrementTapCount(at: tap)
        }
    }

    private func incrementTapCount(at coords: Coordinates) {
        let alreadyTappedThisRound = tapsAddedThisRound.contains(coords)
        tapsAddedThisRound.append(coords)
        guard !alreadyTappedThisRound else {
            return
        }
        self.taps[coords.y][coords.x] += 1
    }
}
