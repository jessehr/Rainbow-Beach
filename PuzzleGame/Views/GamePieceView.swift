//
//  GamePieceView.swift
//  PuzzleGame
//
//  Created by Jesse R on 4/6/24.
//

import SwiftUI

// FIXME: it looks bad between the squares

struct GamePieceView: View {
    let squareWidth: CGFloat
    let squareHeight: CGFloat
    
    let gamePiece: GamePiece
    
    private var canvasWidth: CGFloat {
        gamePiece.widthInSquares * squareWidth
    }
    
    private var canvasHeight: CGFloat {
        gamePiece.heightInSquares * squareHeight
    }
    
    var body: some View {
        Canvas { context, size in
            for squareCoords in gamePiece.normalizedLocalCoords {
                let path = getPath(at: squareCoords)
                context.fill(path, with: .color(.brown))
                
                let sand = Image("sand2")
                let rect = getSquare(at: squareCoords)
                context.draw(sand, in: rect)
            }
        }
        .frame(width: canvasWidth, height: canvasHeight)
    }
    
    private func getPath(at coords: Coordinates) -> Path {
        let square = getSquare(at: coords)
        return Rectangle().path(in: square)
    }
    
    private func getSquare(at coords: Coordinates) -> CGRect {
        return CGRect(
            x: coords.x * squareWidth,
            y: coords.y * squareHeight,
            width: squareWidth,
            height: squareHeight
        )
    }
}

#Preview {
    GamePieceView(
        squareWidth: 100,
        squareHeight: 100,
        gamePiece: GamePiece(
            relativePositions: [
                RelativePosition(rightward: 0, downward: 0),
                RelativePosition(rightward: 0, downward: 1),
                RelativePosition(rightward: 0, downward: 1),
                RelativePosition(rightward: 1, downward: 2)
            ]
        )
    )
}
