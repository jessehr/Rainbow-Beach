//
//  ContentView.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/18/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        GeometryReader { reader in
            GameView(nRows: 13, nColumns: 6, using: reader)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
