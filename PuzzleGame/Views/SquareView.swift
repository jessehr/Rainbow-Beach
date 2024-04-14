//
//  SquareView.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/18/24.
//

import SwiftUI

struct SquareView: View {   
    @ObservedObject var squareManager: SquareManager
    
    let coords: Coordinates
    
    var body: some View {
        ZStack {
            color
            sand
        }
        .smoothAnimation(value: color, for: 0.3)
    }

    var color: Color {
        let square = squareManager.map.square(at: coords)
        return square?.color ?? .black
    }
    
    var sand: some View {
        Image("sand1")
            .resizable()
            .clipped()
    }
}

#Preview {
    SquareView(
        squareManager: SquareManager(),
        coords: Coordinates(x: 0, y: 0)
    )
}
