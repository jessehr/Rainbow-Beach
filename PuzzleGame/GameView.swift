//
//  GameView.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/22/24.
//

import SwiftUI

struct GameView: View {
    let nRows: Int
    let nColumns: Int
    
    @State
    var colors: [[Color]]
    
    init(nRows: Int, nColumns: Int) {
        self.nRows = nRows
        self.nColumns = nColumns
        let sampleRow = Array(repeating: Color.red, count: nColumns)
        self.colors = Array(repeating: sampleRow, count: nRows)
    }
    
    var body: some View {
        GeometryReader { reader in
            let size = self.squareSize(using: reader)
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                ForEach(0..<nRows, id: \.self) { i in
                    GridRow {
                        ForEach(0..<nColumns, id: \.self) { j in
                            SquareView(color: colors[i][j], size: size)
                        }
                    }
                }
            }
            .animation(.smooth(duration: 0.2), value: colors)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        changeSquareColor(using: reader, for: value)
                    }
            )
        }
        .ignoresSafeArea()
    }
    
    func squareSize(using reader: GeometryProxy) -> CGFloat {
        let desiredWidth = reader.size.width / CGFloat(nColumns)
        let desiredHeight = reader.size.height / CGFloat(nRows)
        let actualSize = min(desiredWidth, desiredHeight)
        return actualSize
    }
    
    func changeSquareColor(using reader: GeometryProxy, for dragValue: DragGesture.Value) {
        let percentageDown = dragValue.location.y / reader.size.height
        let rowNumber = Int(floor(CGFloat(nRows) * percentageDown))
        let percentageRight = dragValue.location.x / reader.size.width
        let columnNumber = Int(floor(CGFloat(nColumns) * percentageRight))
        self.colors[rowNumber][columnNumber] = .blue
    }
}

#Preview {
    GameView(nRows: 13, nColumns: 6)
}

// the puzzle could be: can you make the whole screen solid blue? or solid red? with certain moves you can make to try to make it so. Maybe involving flipping or rotating or something.
