//
//  SquareView.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/18/24.
//

import SwiftUI

struct SquareView: View {   
    let color: Color
    let size: Double
    
    var body: some View {
        Rectangle()
            .foregroundStyle(color)
            .frame(width: size, height: size)
    }
}

#Preview {
    SquareView(color: Color.red, size: 100)
}
