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
        square.image
            .resizable()
            .clipped()
    }
}


#Preview {
    SquareView(square: Binding.constant(
        Square(
            depth: 0,
            coords: Coordinates(x: 0, y: 0)
        )
    ))
}
