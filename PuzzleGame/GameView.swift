//
//  GameView.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/22/24.
//

import SwiftUI

struct GameView: View {
    @StateObject
    var tapManager: TapManager
    
    let nRows: Int
    let nColumns: Int
    
    var colors: [[Color]] {
        let colors: [Color] = [.red, .blue, .yellow, .brown, .pink, .white, .mint, .teal]
        return tapManager.taps
            .map {
                $0.map {
                    colors[safe: $0] ?? .black
                }
            }
    }
    
    init(nRows: Int, nColumns: Int) {
        self.nRows = nRows
        self.nColumns = nColumns
        self._tapManager = StateObject(wrappedValue: 
            TapManager(nColumns: nColumns, nRows: nRows)
        )
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
                        let tapCoords = getCoordinates(using: reader, with: value)
                        tapManager.onTap(at: tapCoords)
                    }
                    .onEnded { _ in
                        tapManager.endRound()
                    }
            )
        }
        .ignoresSafeArea()
    }
    
    private func squareSize(using reader: GeometryProxy) -> CGFloat {
        let desiredWidth = reader.size.width / CGFloat(nColumns)
        let desiredHeight = reader.size.height / CGFloat(nRows)
        let actualSize = min(desiredWidth, desiredHeight)
        return actualSize
    }
    
    private func getCoordinates(using reader: GeometryProxy, with dragValue: DragGesture.Value) -> Coordinates {
        let percentageDown = dragValue.location.y / reader.size.height
        let rowNumber = Int(floor(CGFloat(nRows) * percentageDown))
        let percentageRight = dragValue.location.x / reader.size.width
        let columnNumber = Int(floor(CGFloat(nColumns) * percentageRight))
        return Coordinates(x: columnNumber, y: rowNumber)
    }
}

#Preview {
    GameView(nRows: 26, nColumns: 12)
}

// the puzzle could be: can you make the whole screen solid blue? or solid red? with certain moves you can make to try to make it so. Maybe involving flipping or rotating or something.
