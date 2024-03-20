//
//  ButtonView.swift
//  PuzzleGame
//
//  Created by Jesse R on 3/18/24.
//

import SwiftUI

struct ButtonView: View {   
    let color: Color
    
    var body: some View {
        Rectangle()
            .foregroundStyle(color)
    }
}

#Preview {
    ButtonView(color: Color.red)
}
