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
    let isSandy = false
    
    var body: some View {
        Rectangle()
            .foregroundStyle(color)
            .frame(width: size, height: size)
            .overlay {
                if isSandy { randomSand }
            }
    }
    
    var randomSand: some View {
        Canvas { context, size in
            for _ in 0..<800 {
                let point = CGPoint(x: CGFloat.random(in: 0..<size.width), y: CGFloat.random(in: 0..<size.height))
                context.fill(Path(ellipseIn: CGRect(origin: point, size: CGSize(width: 1, height: 1))), with: .color(.black.opacity(0.1)))
            }
        }

    }
}

#Preview {
    SquareView(color: Color.red, size: 100)
}
