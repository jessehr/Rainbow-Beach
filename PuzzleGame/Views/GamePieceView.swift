//
//  GamePieceView.swift
//  PuzzleGame
//
//  Created by Jesse R on 4/6/24.
//

import SwiftUI

struct GamePieceView: View {
    let squareWidth: CGFloat
    let squareHeight: CGFloat
    
    let relativePositions: [RelativePosition]
    
    var body: some View {
        Canvas { context, size in
            let gamePieceCoords = relativePositions.map { $0.asLocalCoords }
            for squareCoords in gamePieceCoords {
                let path = getPath(at: squareCoords)
                context.fill(path, with: .color(.blue))
            }
        }
    }
    
    private func getPath(at coords: Coordinates) -> Path {
        let square = getSquare(at: coords)
        return Rectangle().path(in: square)
    }
    
    private func getSquare(at coords: Coordinates) -> CGRect {
        return CGRect(
            // FIXME: remove these hardcoded weird numbers
            x: (CGFloat(coords.x) + 2.5) * squareWidth,
            y: (CGFloat(coords.y) + 6.0) * squareHeight,
            width: squareWidth,
            height: squareHeight
        )
    }
}

#Preview {
    GamePieceView(
        squareWidth: 100,
        squareHeight: 100,
        relativePositions: [
            RelativePosition(rightward: 0, downward: 0),
            RelativePosition(rightward: 0, downward: 1),
            RelativePosition(rightward: 0, downward: 1),
            RelativePosition(rightward: 1, downward: 2)
        ]
    )
}
