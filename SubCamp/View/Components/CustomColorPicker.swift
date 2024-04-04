//
//  ColorPicker.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 31.03.24.
//

import SwiftUI

struct CustomColorPicker: View {
    @Binding var selectedColor: Color
    @AppStorage("designIconRound") var designIconRound: Bool = false

    let colors: [Color] = [.blue, .indigo, .purple, .pink, .red, .orange, .yellow, .green,  .gray, .black]
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    let size = 40.00

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(colors, id: \.self) { color in
                    Button(action: {
                        self.selectedColor = color
                    }) {
                        if designIconRound {
                            Image(systemName: self.selectedColor == color ? "circle.inset.filled" : "circle.fill")
                                .resizable()
                                .frame(width: size, height: size)
                        } else {
                            Image(systemName: self.selectedColor == color ? "square.inset.filled" : "square.fill")
                                .resizable()
                                .frame(width: size, height: size)
                        }
                    }.accentColor(color)
                }
            }
        }
    }
}

#Preview("Add Contract") {
    Form {
        @State var selectedColor = Color.red

        CustomColorPicker(selectedColor: $selectedColor)
    }
}
