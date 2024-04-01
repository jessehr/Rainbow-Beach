//
//  GameView.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/22/24.
//

import SwiftUI

struct GameView: View {
    let nRows: Int
    let nColumns: Int
    
    let reader: GeometryProxy
        
    @StateObject
    var squareManager: SquareManager
    
    let soundManager: SoundManager
    
    var gameWidth: CGFloat {
        reader.size.width
    }
    
    var gameHeight: CGFloat {
        reader.size.height
    }
    
    var squareWidth: CGFloat {
        gameWidth / CGFloat(nColumns)
    }
    
    var squareHeight: CGFloat {
        gameHeight / CGFloat(nRows)
    }
    
    init(nRows: Int, nColumns: Int, using reader: GeometryProxy) {
        self.nRows = nRows
        self.nColumns = nColumns
        self.reader = reader
        self.soundManager = SoundManager(filename: Constants.dragSoundFilename)
        self._squareManager = StateObject(wrappedValue:
            SquareManager()
        )
    }
    
    var body: some View {
        totalView
            .gesture(gestures)
            .sensoryFeedback(
                .impact(flexibility: .rigid, intensity: 0.5),
                trigger: squareManager.sandyCoords
            )
            .onChange(of: squareManager.map.isSolved) {
                if squareManager.map.isSolved {
                    squareManager.incrementLevel()
                }
            }
    }
    
    private var totalView: some View {
        ZStack {
            gridView
            allSandView
        }
    }
    
    private var gridView: some View {
        ForEach(0..<nRows, id: \.self) { i in
            ForEach(0..<nColumns, id: \.self) { j in
                squareView(at: Coordinates(x: j, y: i))
            }
        }
    }
    
    @ViewBuilder
    private var allSandView: some View {
        ForEach(sandyPositions.indices, id: \.self) { index in
            sandSquareView
                .possiblePosition(sandyPositions[index])
        }
    }
    
    private var sandSquareView: some View {
        SandView(baseColor: .brown, sandAggressionFactor: 1.0)
            .frame(width: squareWidth, height: squareHeight)
            .animation(
                .smooth(duration: Constants.dragAnimationLength),
                value: squareManager.sandyCoords
            )
    }
    
    private func squareView(at coords: Coordinates) -> some View {
        SquareView(square: $squareManager.map.squares[coords.y][coords.x])
            .frame(width: squareWidth, height: squareHeight)
            .possiblePosition(position(from: coords))
    }
    
    private var gestures: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                onDrag(with: value)
            }
            .onEnded { _ in
                squareManager.dropSand()
            }
    }
    
    private func onDrag(with value: DragGesture.Value) {
        let tapCoords = coordinates(from: value.location)
        guard squareManager.baseSandySquareCoords != tapCoords else {
            return
        }
        soundManager.play(for: Constants.dragAnimationLength)
        squareManager.baseSandySquareCoords = tapCoords
    }

    private func coordinates(from position: CGPoint) -> Coordinates {
        let percentageDown = position.y / gameHeight
        let rowNumber = Int(floor(CGFloat(nRows) * percentageDown))
        let percentageRight = position.x / gameWidth
        let columnNumber = Int(floor(CGFloat(nColumns) * percentageRight))
        return Coordinates(x: columnNumber, y: rowNumber)
    }
    
    private func position(from coordinates: Coordinates) -> CGPoint? {
        let x = (CGFloat(coordinates.x) + 0.5) * squareWidth
        let y = (CGFloat(coordinates.y) + 0.5) * squareHeight
        if x >= 0 && x < gameWidth && y >= 0 && y < gameHeight {
            return CGPoint(x: x, y: y)
        } else {
            return nil
        }
    }
    
    private var sandyPositions: [CGPoint] {
        return squareManager.sandyCoords.compactMap { position(from: $0) }
    }
}

#Preview {
    GeometryReader { reader in
        GameView(nRows: 26, nColumns: 12, using: reader)
    }
}
