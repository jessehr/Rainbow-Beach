//
//  ContentView.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/18/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    let nRows = 13
    let nColumns = 6
    
    var body: some View {
        GeometryReader { reader in
            let desiredWidth = reader.size.width / CGFloat(nColumns)
            let desiredHeight = reader.size.height / CGFloat(nRows)
            let actualSize = min(desiredWidth, desiredHeight)
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                ForEach(0..<nRows, id: \.self) { _ in
                    GridRow {
                        ForEach(0..<nColumns, id: \.self) { _ in
                            ButtonView()
                                .frame(width: actualSize, height: actualSize)
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
        //.modelContainer(for: Item.self, inMemory: true)
}
