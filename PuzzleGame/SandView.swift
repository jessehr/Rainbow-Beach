//
//  SandView.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/24/24.
//

import SwiftUI

struct SandView: View {
    var body: some View {
        Color.brown
            .overlay {
                sand
            }
    }
    
    var sand: some View {
        return Canvas { context, size in
            randomSand(
                color: Color.white,
                opacity: 0.3,
                nParticles: 1000,
                size: size,
                context: context
            )
            randomSand(
                color: Color.black,
                opacity: 0.2,
                nParticles: 1000,
                size: size,
                context: context
            )
        }
        
        func randomSand(
            color: Color,
            opacity: CGFloat,
            nParticles: Int,
            size: CGSize,
            context: GraphicsContext
        ) {
            for _ in 0..<nParticles {
                let point = CGPoint(
                    x: CGFloat.random(in: 0..<size.width),
                    y: CGFloat.random(in: 0..<size.height)
                )
                context.fill(
                    Path(
                        ellipseIn: CGRect(origin: point, size: CGSize(width: 1, height: 1))
                    ),
                    with: .color(color.opacity(opacity))
                )
            }

        }
        
    }
}

#Preview {
    SandView()
}
