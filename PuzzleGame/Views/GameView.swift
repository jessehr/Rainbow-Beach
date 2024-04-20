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
        squareManager.level.map.squares.count
    }
    
    var nColumns: Int {
        squareManager.level.map.squares.first?.count ?? 0
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
    
    @State
    private var touchInfoString = ""
    
    init(using reader: GeometryProxy) {
        self.reader = reader
        self.soundManager = SoundManager(filename: Constants.dropSoundFilename)
        self._squareManager = StateObject(wrappedValue:
            SquareManager()
        )
    }
    
    var body: some View {
        ZStack {
            totalViewWithModifiers
            TouchHandler(touchInfo: $touchInfoString)
                .onChanged { value in
                    print(value)
                }
                .onEnded { value in
                    print("ended: \(value)")
                }
        }
    }
    
    private var totalViewWithModifiers: some View {
        totalView
            .gesture(gestures)
            .sensoryFeedback(
                .impact(flexibility: .rigid, intensity: 0.6),
                trigger: squareManager.gamePieceCoords
            )
            .onChange(of: squareManager.level.map.isSolved) {
                if squareManager.level.map.isSolved {
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
            gamePieceViewPositioned
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
        .opacity(squareManager.gamePieceCanDrop ? 1.0 : 0.5)
        .smoothAnimation(value: squareManager.gamePieceCanDrop)
    }
    
    private var gamePieceViewPositioned: some View {
        gamePieceView
            .possiblePosition(position(atCenterOf: squareManager.baseGamePieceCoords))
            .smoothAnimation(value: squareManager.gamePieceCoords)
            .offset(gamePieceOffset)
    }
    
    private var gamePieceOffset: CGSize {
        CGSize(
            width: 0.5 * squareWidth * (squareManager.gamePiece.widthInSquares - 1),
            height: 0.5 * squareHeight * (squareManager.gamePiece.heightInSquares - 1)
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
        SquareView(square: $squareManager.level.map.squares[coords.y][coords.x])
            .frame(width: squareWidth, height: squareHeight)
            .possiblePosition(position(atCenterOf: coords))
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
    
    private func position(atCenterOf coordinates: Coordinates?) -> CGPoint? {
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
