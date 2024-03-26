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
            GameView(
                nRows: 26,
                nColumns: 12,
                width: reader.size.width,
                height: reader.size.height
            )
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
