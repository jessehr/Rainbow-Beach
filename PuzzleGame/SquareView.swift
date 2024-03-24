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
        Rectangle()
            .foregroundStyle(square.color)
            .animation(.smooth(duration: 0.2), value: square.color)
            .overlay {
                if square.hasHoveringSand { sandView }
            }
    }
    
    var sandView: some View {
        Color.brown
            .overlay {
                SandView()
            }
    }
}

#Preview {
    SquareView(square: Binding.constant(Square(depth: 0)))
}
