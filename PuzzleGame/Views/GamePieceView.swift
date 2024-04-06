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
    
    let squaresCoords: [Coordinates]
    
    var body: some View {
        Canvas { context, size in
            for squareCoords in squaresCoords {
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
        squaresCoords: [Coordinates(x: 0,y: 0)]
    )
}
