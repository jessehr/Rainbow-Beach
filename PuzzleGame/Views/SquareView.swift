//
//  SquareView.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/18/24.
//

import SwiftUI

struct SquareView: View {   
    @Binding var square: Square
    
    var body: some View {
        SandView(baseColor: square.color, sandAggressionFactor: 0.7)
            .animation(.smooth(duration: 0.3), value: square.color)
    }
}

#Preview {
    SquareView(square: Binding.constant(Square(depth: 0)))
}
