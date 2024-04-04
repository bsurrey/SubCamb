//
//  ContractLabelIcon.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 03.04.24.
//

import SwiftUI

struct ContractLabelIcon: View {
    var symbol: String = "gear"
    var selectedColor: Color = .blue
    var size = 60.0
    var font: Font = .title
    
    @AppStorage("designIconGradient") var designIconGradient: Bool = false
    @AppStorage("designIconRound") var designIconRound: Bool = false
    
    var body: some View {
        Label("", systemImage: symbol)
            .font(font)
            .labelStyle(.iconOnly)
            .frame(width: size, height: size)
            .foregroundColor(.white)
            .conditionaBackgroundShape(isCicrle: designIconRound)
            .conditionalBackgroundStyle(isGradient: designIconGradient, color: selectedColor)
    }
}

extension View {
    func conditionaBackgroundShape(isCicrle: Bool) -> some View {
        self.modifier(ConditionalBackgroundShape(isCircle: isCicrle))
    }
    
    func conditionalBackgroundStyle(isGradient: Bool, color: Color) -> some View {
        self.modifier(ConditionalBackgroundStyle(isGradient: isGradient, color: color))
    }
}

struct ConditionalBackgroundShape: ViewModifier {
    var isCircle: Bool
    
    func body(content: Content) -> some View {
        if isCircle {
            content
                .background(in: Circle())
        } else {
            content
                .background(in: RoundedRectangle(cornerRadius: 8))
        }
    }
}

struct ConditionalBackgroundStyle: ViewModifier {
    var isGradient: Bool
    var color: Color
    
    func body(content: Content) -> some View {
        if isGradient {
            content
                .backgroundStyle(color.gradient)
        } else {
            content
                .backgroundStyle(color)
        }
    }
}

#Preview {
    ContractLabelIcon()
}
