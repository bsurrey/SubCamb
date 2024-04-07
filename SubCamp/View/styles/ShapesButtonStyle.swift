//
//  ShapesButtonStyle.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 07.04.24.
//

import SwiftUI

struct ShapesButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(minWidth: 125, minHeight: 60)
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.bottom, 30)
    }
}

#Preview {
    Button() {
    } label: {
        Label("Reset", systemImage: "arrow.counterclockwise")
    }
    .buttonStyle(ShapesButton())
}
