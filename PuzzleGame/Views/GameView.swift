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
    var viewModel: GameViewModel
    
    let soundManager: SoundManager
    
    var nRows: Int {
        viewModel.level.map.squares.count
    }
    
    var nColumns: Int {
        viewModel.level.map.squares.first?.count ?? 0
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
        self._viewModel = StateObject(wrappedValue:
            GameViewModel()
        )
    }
    
    var body: some View {
        ZStack {
            totalViewWithModifiers
            touchHandler
        }
    }
    
    private var touchHandler: some View {
        TouchHandler(touchPoints: $viewModel.touchPoints)
            .onChange(of: viewModel.touchPoints) { oldPoints, newPoints in
                guard let newPrimaryTouch = newPoints.primaryTouch else {
                    onTouchEnded()
                    return
                }
                
                guard let newSecondaryTouch = newPoints.secondaryTouch else {
                    onDrag(to: newPrimaryTouch.point)
                    return
                }
                
                onMultitouch(
                    newPrimaryTouch: newPrimaryTouch,
                    newSecondaryTouch: newSecondaryTouch,
                    oldPrimaryTouch: oldPoints.primaryTouch,
                    oldSecondaryTouch: oldPoints.secondaryTouch
                )
            }
    }
    
    private func onMultitouch(
        newPrimaryTouch: TouchPoint,
        newSecondaryTouch: TouchPoint,
        oldPrimaryTouch: TouchPoint?,
        oldSecondaryTouch: TouchPoint?
    ) {
        print("TODO: implement multi touch behavior")
    }

    private func onTouchEnded() {
        do {
            try viewModel.dropGamePieceSand()
            soundManager.play(for: Constants.dropAnimationLength)
        } catch {
        }
    }
    
    private var totalViewWithModifiers: some View {
        totalView
            .sensoryFeedback(
                .impact(flexibility: .rigid, intensity: 0.6),
                trigger: viewModel.gamePieceCoords
            )
            .onChange(of: viewModel.level.map.isSolved) {
                if viewModel.level.map.isSolved {
                    viewModel.incrementLevel()
                }
            }
            .onShake {
                viewModel.reset()
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
            gamePiece: viewModel.gamePiece
        )
        .opacity(viewModel.gamePieceCanDrop ? 1.0 : 0.5)
        .smoothAnimation(value: viewModel.gamePieceCanDrop)
    }
    
    private var gamePieceViewPositioned: some View {
        gamePieceView
            .possiblePosition(position(atCenterOf: viewModel.baseGamePieceCoords))
            .smoothAnimation(value: viewModel.gamePieceCoords)
            .offset(gamePieceOffset)
    }
    
    private var gamePieceOffset: CGSize {
        CGSize(
            width: 0.5 * squareWidth * (viewModel.gamePiece.widthInSquares - 1),
            height: 0.5 * squareHeight * (viewModel.gamePiece.heightInSquares - 1)
        )
    }
    
    @ViewBuilder
    private var winningView: some View {
        if viewModel.outOfLevels {
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
        SquareView(square: $viewModel.level.map.squares[coords.y][coords.x])
            .frame(width: squareWidth, height: squareHeight)
            .possiblePosition(position(atCenterOf: coords))
    }
    
    private func onDrag(to point: CGPoint) {
        let tapCoords = coordinates(from: point)
        guard viewModel.baseGamePieceCoords != tapCoords else {
            return
        }
        viewModel.baseGamePieceCoords = tapCoords
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
