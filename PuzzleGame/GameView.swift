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
    
    var gameWidth: CGFloat {
        reader.size.width
    }
    
    var gameHeight: CGFloat {
        reader.size.height
    }
    
    var squareWidth: CGFloat {
        gameWidth / CGFloat(nColumns)
    }
    
    var squareHeight: CGFloat {
        gameHeight / CGFloat(nRows)
    }
    
    init(nRows: Int, nColumns: Int, using reader: GeometryProxy) {
        self.nRows = nRows
        self.nColumns = nColumns
        self.reader = reader
        self._squareManager = StateObject(wrappedValue:
            SquareManager(nColumns: nColumns, nRows: nRows)
        )
    }
    
    var body: some View {
        totalView
            .gesture(gestures)
            .sensoryFeedback(
                .impact(flexibility: .rigid, intensity: 0.5),
                trigger: squareManager.sandyCoords
            )
    }
    
    private var totalView: some View {
        ZStack {
            gridView
            possibleSandView
        }
    }
    
    private var gridView: some View {
        ForEach(0..<nRows, id: \.self) { i in
            ForEach(0..<nColumns, id: \.self) { j in
                squareView(at: Coordinates(x: j, y: i))
            }
        }
    }
    
    @ViewBuilder
    private var possibleSandView: some View {
        if let sandyPosition {
            SandView()
                .frame(width: squareWidth, height: squareHeight)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .position(sandyPosition)
                .animation(.smooth(duration: 0.1), value: squareManager.sandyCoords)
        }
    }
    
    private func squareView(at coords: Coordinates) -> some View {
        SquareView(square: $squareManager.squares[coords.y][coords.x])
            .frame(width: squareWidth, height: squareHeight)
            .position(position(from: coords))
    }
    
    private var gestures: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                let tapCoords = coordinates(from: value.location)
                withAnimation {
                    squareManager.sandyCoords = tapCoords
                }
            }
            .onEnded { _ in
                squareManager.dropSand()
            }
    }
    
    private func coordinates(from position: CGPoint) -> Coordinates {
        let percentageDown = position.y / gameHeight
        let rowNumber = Int(floor(CGFloat(nRows) * percentageDown))
        let percentageRight = position.x / gameWidth
        let columnNumber = Int(floor(CGFloat(nColumns) * percentageRight))
        return Coordinates(x: columnNumber, y: rowNumber)
    }
    
    private func position(from coordinates: Coordinates) -> CGPoint {
        let x = (CGFloat(coordinates.x) + 0.5) * squareWidth
        let y = (CGFloat(coordinates.y) + 0.5) * squareHeight
        return CGPoint(x: x, y: y)
    }
    
    private var sandyPosition: CGPoint? {
        guard let sandyCoords = squareManager.sandyCoords else {
            return nil
        }
        return position(from: sandyCoords)
    }
}

#Preview {
    GeometryReader { reader in
        GameView(nRows: 26, nColumns: 12, using: reader)
    }
}
