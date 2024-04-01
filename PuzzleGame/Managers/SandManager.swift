//
//  SandManager.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/31/24.
//

import Foundation
import SwiftUI

class SandManager: ObservableObject {
    var particles: [Particle]
    
    init() {
        self.particles = []
    }
    
    func instantiateParticles(with size: CGSize, sandAggressionFactor: Double) {
        var particles: [Particle] = []
        particles.append(contentsOf:
            makeParticles(
                with: size,
                color: .black.opacity(0.2),
                count: Int(1000 * sandAggressionFactor)
            )
        )
        particles.append(contentsOf: 
            makeParticles(
                with: size,
                color: .white.opacity(0.3),
                count: Int(1000 * sandAggressionFactor)
            )
        )
        self.particles = particles
    }
    
    private func makeParticles(with size: CGSize, color: Color, count: Int) -> [Particle] {
        var particles: [Particle] = []
        for _ in 0..<count {
            let point = CGPoint(
                x: CGFloat.random(in: 0..<size.width),
                y: CGFloat.random(in: 0..<size.height)
            )
            particles.append(
                Particle(
                    point: point,
                    color: color
                )
            )
        }
        return particles
    }
}

struct Particle {
    let point: CGPoint
    let color: Color
    
    var asRect: CGRect {
        CGRect(origin: point, size: CGSize(width: 1, height: 1))
    }
}
