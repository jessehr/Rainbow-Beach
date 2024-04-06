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
        let containerRect = getContainerRect(at: coords)
        return Rectangle().path(in: containerRect)
    }
    
    private func getContainerRect(at coords: Coordinates) -> CGRect {
        return CGRect(
            x: CGFloat(coords.x) * squareWidth,
            y: CGFloat(coords.y) * squareHeight,
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
