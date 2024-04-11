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
            .smoothAnimation(value: square.color, for: 0.3)
    }
}

#Preview {
    SquareView(square: Binding.constant(Square(depth: 0)))
}
