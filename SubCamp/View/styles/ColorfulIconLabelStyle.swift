//
//  ColorfulIconLabelStyle.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 06.04.24.
//

import Foundation
import SwiftUI

struct ColorfulIconLabelStyle: LabelStyle {
    var color: Color = .black
    var size: CGFloat = 1
    
    init(_ color: Color = .black, size: CGFloat = 1) {
        self.color = color
        self.size = size
    }
    
    func makeBody(configuration: Configuration) -> some View {
        Label {
            configuration.title
        } icon: {
            configuration.icon
                .imageScale(.medium)
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 7 * size).frame(width: 28 * size, height: 28 * size).foregroundColor(color))
        }
    }
}
