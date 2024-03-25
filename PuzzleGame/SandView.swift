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
        Canvas { context, size in
            for _ in 0..<1200 {
                let point = CGPoint(
                    x: CGFloat.random(in: 0..<size.width),
                    y: CGFloat.random(in: 0..<size.height)
                )
                context.fill(
                    Path(
                        ellipseIn: CGRect(origin: point, size: CGSize(width: 1, height: 1))),
                        with: .color(.black.opacity(0.2)
                    )
                )
            }
        }
    }
}

#Preview {
    SandView()
}
