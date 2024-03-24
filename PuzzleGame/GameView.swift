//
//  GameView.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/22/24.
//

import SwiftUI

struct GameView: View {
    @StateObject
    var squareManager: SquareManager
    
    let nRows: Int
    let nColumns: Int
    
    init(nRows: Int, nColumns: Int) {
        self.nRows = nRows
        self.nColumns = nColumns
        self._squareManager = StateObject(wrappedValue:
            SquareManager(nColumns: nColumns, nRows: nRows)
        )
    }
    
    var body: some View {
        GeometryReader { reader in
            gridView(using: reader)
                .gesture(gestures(using: reader))
        }
        .ignoresSafeArea()
    }
    
    private func gridView(using reader: GeometryProxy) -> some View {
        let size = self.squareSize(using: reader)
        return Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<nRows, id: \.self) { i in
                GridRow {
                    ForEach(0..<nColumns, id: \.self) { j in
                        SquareView(square: $squareManager.squares[i][j])
                            .frame(width: size, height: size)
                    }
                }
            }
        }
    }
    
    private func gestures(using reader: GeometryProxy) -> some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                let tapCoords = getCoordinates(using: reader, with: value)
                squareManager.onHover(at: tapCoords)
            }
            .onEnded { value in
                let releaseCoords = getCoordinates(using: reader, with: value)
                squareManager.onRelease(at: releaseCoords)
            }
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
