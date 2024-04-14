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
        ZStack {
            square.color
            sand
        }
        .smoothAnimation(value: square.color, for: 0.3)
    }
    
    var sand: some View {
        Image("sand1")
            .resizable()
            .clipped()
    }
}

#Preview {
    SquareView(square: Binding.constant(Square(depth: 0)))
}
