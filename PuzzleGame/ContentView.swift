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
    
    @State
    var colors: [[Color]]
    
    init() {
        let sampleRow = Array(repeating: Color.red, count: nColumns)
        self.colors = Array(repeating: sampleRow, count: nRows)
    }
    
    var body: some View {
        GeometryReader { reader in
            let desiredWidth = reader.size.width / CGFloat(nColumns)
            let desiredHeight = reader.size.height / CGFloat(nRows)
            let actualSize = min(desiredWidth, desiredHeight)
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                ForEach(0..<nRows, id: \.self) { i in
                    GridRow {
                        ForEach(0..<nColumns, id: \.self) { j in
                            ButtonView(color: colors[i][j])
                                .frame(width: actualSize, height: actualSize)
                        }
                    }
                }
            }
            .animation(.smooth(duration: 0.5), value: colors)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        let percentageDown = value.location.y / reader.size.height
                        let rowNumber = Int(floor(CGFloat(nRows) * percentageDown))
                        let percentageRight = value.location.x / reader.size.width
                        let columnNumber = Int(floor(CGFloat(nColumns) * percentageRight))
                        self.colors[rowNumber][columnNumber] = .blue
                    }
            )
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
        //.modelContainer(for: Item.self, inMemory: true)
}
