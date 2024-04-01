//
//  SandView.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/24/24.
//

import SwiftUI

struct SandView: View {
    let baseColor: Color
    let sandAggressionFactor: Double
    
    @StateObject
    var sandManager = SandManager()
    
    var body: some View {
        baseColor
            .overlay {
                sand
            }
    }
    
    var sand: some View {
        return Canvas { context, size in
            if sandManager.particles.isEmpty {
                sandManager.instantiateParticles(with: size, sandAggressionFactor: sandAggressionFactor)
            }
            for particle in sandManager.particles {
                context.fill(
                    Path(ellipseIn: particle.asRect),
                    with: .color(particle.color)
                )
            }
        }
    }
}

#Preview {
    SandView(baseColor: .brown, sandAggressionFactor: 1.0)
}
