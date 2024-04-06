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
    
    var body: some View {
        Canvas { context, size in
            let newSize = CGSizeMake(squareWidth, squareHeight)
            let containerRect = CGRect(origin: .zero, size: newSize)
            let path = Rectangle().path(in: containerRect)
            context.fill(path, with: .color(.blue))
        }
    }
}

#Preview {
    GamePieceView(squareWidth: 100, squareHeight: 100)
}
