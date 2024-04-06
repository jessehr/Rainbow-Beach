//
//  GamePieceView.swift
//  PuzzleGame
//
//  Created by Jesse R on 4/6/24.
//

import SwiftUI

struct GamePieceView: View {
    var body: some View {
        Canvas { context, size in
            let containerRect = CGRect(origin: .zero, size: size)
            let path = Circle().path(in: containerRect)
            context.fill(path, with: .color(.yellow))
        }
    }
}

#Preview {
    GamePieceView()
}
