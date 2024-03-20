//
//  ButtonView.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/18/24.
//

import SwiftUI

struct ButtonView: View {
    @State
    private var buttonColor: Color = .red
    
    var body: some View {
        Rectangle()
            .foregroundStyle(buttonColor)
            .animation(.smooth(duration: 0.15), value: buttonColor)
            .onTapGesture {
                onButtonTap()
            }
    }
    
    func onButtonTap() {
        buttonColor = (buttonColor == .red) ? .yellow : .red
    }
}

#Preview {
    ButtonView()
}
