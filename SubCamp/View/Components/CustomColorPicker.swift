//
//  ColorPicker.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 31.03.24.
//

import SwiftUI

struct CustomColorPicker: View {
    @Binding var selectedColor: Color
    let colors: [Color] = [.blue, .indigo, .purple, .pink, .red, .orange, .yellow, .green,  .gray, .black]

    
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(colors, id: \.self) { color in
                    Button(action: {
                        self.selectedColor = color
                    }) {
                        Image(systemName: self.selectedColor == color ? "square.inset.filled" : "square.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }.accentColor(color)
                }
            }
        }
        .padding(.trailing, -20.0)
    }
}

#Preview("Add Contract") {
    Form {
        @State var selectedColor = Color.red

        CustomColorPicker(selectedColor: $selectedColor)
    }
}
