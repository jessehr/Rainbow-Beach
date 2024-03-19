//
//  ContentView.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/18/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State
    private var buttonColor: Color = .red
    var body: some View {
        Button {
            buttonColor = buttonColor == .blue ? .red : .blue
        } label: {
            buttonColor
                .frame(width: 50, height: 50)
                .cornerRadius(10)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
