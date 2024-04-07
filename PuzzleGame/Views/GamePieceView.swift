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
    
    private var normalizedLocalCoords: [Coordinates] {
        let xMin = relativePositions.map { $0.rightward }.min() ?? 0
        let yMin = relativePositions.map { $0.downward }.min() ?? 0
        return relativePositions.map { position in
            Coordinates(
                x: position.rightward - xMin,
                y: position.downward - yMin
            )
        }
    }
    
    private var canvasWidth: CGFloat {
        let xMin = relativePositions.map { $0.rightward }.min() ?? 0
        let xMax = relativePositions.map { $0.rightward }.max() ?? 0
        let diff = xMax - xMin
        return (diff + 1) * squareWidth
    }
    
    private var canvasHeight: CGFloat {
        let yMin = relativePositions.map { $0.downward }.min() ?? 0
        let yMax = relativePositions.map { $0.downward }.max() ?? 0
        let diff = yMax - yMin
        return (diff + 1) * squareHeight
    }
    
    var body: some View {
        Canvas { context, size in
            for squareCoords in normalizedLocalCoords {
                let path = getPath(at: squareCoords)
                context.fill(path, with: .color(.blue))
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
        relativePositions: [
            RelativePosition(rightward: 0, downward: 0),
            RelativePosition(rightward: 0, downward: 1),
            RelativePosition(rightward: 0, downward: 1),
            RelativePosition(rightward: 1, downward: 2)
        ]
    )
}
