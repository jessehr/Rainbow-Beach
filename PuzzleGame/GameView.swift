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
    
    let reader: GeometryProxy
    
    @StateObject
    var squareManager: SquareManager

    init(nRows: Int, nColumns: Int, using reader: GeometryProxy) {
        self.nRows = nRows
        self.nColumns = nColumns
        self.reader = reader
        self._squareManager = StateObject(wrappedValue:
            SquareManager(nColumns: nColumns, nRows: nRows)
        )
    }
    
    var body: some View {
        gridView
            .gesture(gestures)
    }
    
    private var gridView: some View {
        return Grid(horizontalSpacing: 0, verticalSpacing: 0) {
            ForEach(0..<nRows, id: \.self) { i in
                GridRow {
                    ForEach(0..<nColumns, id: \.self) { j in
                        SquareView(square: $squareManager.squares[i][j])
                            .frame(width: squareSize, height: squareSize)
                    }
                }
            }
        }
    }
    
    private var gestures: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                let tapCoords = getCoordinates(with: value)
                squareManager.onHover(at: tapCoords)
            }
            .onEnded { value in
                let releaseCoords = getCoordinates(with: value)
                squareManager.onRelease(at: releaseCoords)
            }
    }
    
    private var squareSize: CGFloat {
        let desiredWidth = reader.size.width / CGFloat(nColumns)
        let desiredHeight = reader.size.height / CGFloat(nRows)
        let actualSize = min(desiredWidth, desiredHeight)
        return actualSize
    }
    
    private func getCoordinates(with dragValue: DragGesture.Value) -> Coordinates {
        let percentageDown = dragValue.location.y / reader.size.height
        let rowNumber = Int(floor(CGFloat(nRows) * percentageDown))
        let percentageRight = dragValue.location.x / reader.size.width
        let columnNumber = Int(floor(CGFloat(nColumns) * percentageRight))
        return Coordinates(x: columnNumber, y: rowNumber)
    }
}

#Preview {
    GeometryReader { reader in
        GameView(nRows: 26, nColumns: 12, using: reader)
    }
}
