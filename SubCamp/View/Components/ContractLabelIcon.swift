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
    
    var body: some View {
        Label("", systemImage: symbol)
            .font(.title)
            .labelStyle(.iconOnly)
            .frame(width: size, height: size)
            .background(in:             RoundedRectangle(cornerRadius: 8))
            .backgroundStyle(selectedColor.gradient)
        
    }
}

#Preview {
    ContractLabelIcon()
}
