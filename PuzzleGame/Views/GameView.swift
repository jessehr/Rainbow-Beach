//
//  GameView.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/22/24.
//

import SwiftUI

struct GameView: View {
    let reader: GeometryProxy
        
    @StateObject
    var squareManager: SquareManager
    
    let soundManager: SoundManager
    
    var nRows: Int {
        squareManager.map.squares.count
    }
    
    var nColumns: Int {
        squareManager.map.squares.first?.count ?? 0
    }
    
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
    
    init(using reader: GeometryProxy) {
        self.reader = reader
        self.soundManager = SoundManager(filename: Constants.dropSoundFilename)
        self._squareManager = StateObject(wrappedValue:
            SquareManager()
        )
    }
    
    var body: some View {
        totalView
            .gesture(gestures)
            .sensoryFeedback(
                .impact(flexibility: .rigid, intensity: 0.6),
                trigger: squareManager.sandyCoords
            )
            .onChange(of: squareManager.map.isSolved) {
                if squareManager.map.isSolved {
                    squareManager.incrementLevel()
                }
            }
            .onShake {
                squareManager.reset()
            }
    }
    
    private var totalView: some View {
        ZStack {
            gridView
            winningView
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
        GamePieceView(
            squareWidth: squareWidth,
            squareHeight: squareHeight,
            squaresCoords: squareManager.sandyCoords
        )

        //        ForEach(sandyPositions.indices, id: \.self) { index in
        //            sandSquareView
        //                .possiblePosition(sandyPositions[index])
        //                .opacity(squareManager.allSandCanDrop ? 1.0 : 0.5)
        //                .animation(
        //                    .smooth(duration: Constants.dropAnimationLength),
        //                    value: squareManager.allSandCanDrop
        //                )
        //        }
    }
    
    @ViewBuilder
    private var winningView: some View {
        if squareManager.outOfLevels {
            Text("You won! Yay!")
                .font(.largeTitle)
                .bold()
                .italic()
                .foregroundStyle(Color.blue)
                .padding(4)
                .background(Color.white.opacity(0.5))
        }
    }
    
    private var sandSquareView: some View {
        SandView(baseColor: .brown, sandAggressionFactor: 1.0)
            .frame(width: squareWidth, height: squareHeight)
            .animation(
                .smooth(duration: Constants.dropAnimationLength),
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
                do {
                    try squareManager.dropSand()
                    soundManager.play(for: Constants.dropAnimationLength)
                } catch { }
            }
    }
    
    private func onDrag(with value: DragGesture.Value) {
        let tapCoords = coordinates(from: value.location)
        guard squareManager.baseSandySquareCoords != tapCoords else {
            return
        }
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
        GameView(using: reader)
    }
}
