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
        gameWidth / nColumns
    }
    
    var squareHeight: CGFloat {
        gameHeight / nRows
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
                trigger: squareManager.gamePieceCoords
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
            gamePieceView
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
    private var gamePieceView: some View {
        GamePieceView(
            squareWidth: squareWidth,
            squareHeight: squareHeight,
            gamePiece: squareManager.gamePiece
        )
        .possiblePosition(centerPosition(from: squareManager.baseGamePieceCoords))
        .offset(
            x: 0.5 * squareWidth * (squareManager.gamePiece.widthInSquares - 1),
            y: 0.5 * squareHeight * (squareManager.gamePiece.heightInSquares - 1)
        )
        .animation(
            .smooth(duration: Constants.dropAnimationLength),
            value: squareManager.gamePieceCoords
        )
        .opacity(squareManager.gamePieceCanDrop ? 1.0 : 0.5)
        .animation(
            .smooth(duration: Constants.dropAnimationLength),
            value: squareManager.gamePieceCanDrop
        )
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
    
    private func squareView(at coords: Coordinates) -> some View {
        SquareView(square: $squareManager.map.squares[coords.y][coords.x])
            .frame(width: squareWidth, height: squareHeight)
            .possiblePosition(centerPosition(from: coords))
    }
    
    private var gestures: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                onDrag(with: value)
            }
            .onEnded { _ in
                do {
                    try squareManager.dropGamePieceSand()
                    soundManager.play(for: Constants.dropAnimationLength)
                } catch { }
            }
    }
    
    private func onDrag(with value: DragGesture.Value) {
        let tapCoords = coordinates(from: value.location)
        guard squareManager.baseGamePieceCoords != tapCoords else {
            return
        }
        squareManager.baseGamePieceCoords = tapCoords
    }

    private func coordinates(from position: CGPoint) -> Coordinates {
        let percentageDown = position.y / gameHeight
        let rowNumber = Int(floor(nRows * percentageDown))
        let percentageRight = position.x / gameWidth
        let columnNumber = Int(floor(nColumns * percentageRight))
        return Coordinates(x: columnNumber, y: rowNumber)
    }
    
    private func centerPosition(from coordinates: Coordinates?) -> CGPoint? {
        guard let coordinates else { return nil }
        let x = (coordinates.x + 0.5) * squareWidth
        let y = (coordinates.y + 0.5) * squareHeight
        if x >= 0 && x < gameWidth && y >= 0 && y < gameHeight {
            return CGPoint(x: x, y: y)
        } else {
            return nil
        }
    }
}

#Preview {
    GeometryReader { reader in
        GameView(using: reader)
    }
}
