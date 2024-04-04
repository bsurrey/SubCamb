//
//  SettingsLookAndFeelView.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 04.04.24.
//

import SwiftUI

struct SettingsLookAndFeelView: View {
    
    enum AppApperance: String, CaseIterable, Identifiable {
        case system, dark, light
        var id: Self { self }
    }

    @State private var selectedApperance: AppApperance = .system
    
    @AppStorage("designIconGradient") var designIconGradient: Bool = false
    @AppStorage("designIconRound") var designIconRound: Bool = false
    @AppStorage("designColoredBackgroundAmounts") var designColoredBackgroundAmounts: Bool = true
    @AppStorage("designColoredAmounts") var designColoredAmounts: Bool = true
    @State var col: Color = .blue

    var body: some View {
        List {
            ContractCard(contract: Contract.demoIncome)
            ContractCard(contract: Contract.demoExpense)
            
            Section {
                Toggle("Icon gradient", systemImage: "slider.horizontal.3", isOn: $designIconGradient)
                Toggle("Round icon", systemImage: designIconRound ? "circle.fill" : "circle", isOn: $designIconRound)
                Toggle("Colored Backgrounds for Amounts", systemImage: designColoredBackgroundAmounts ? "rectangle.fill" :  "rectangle", isOn: $designColoredBackgroundAmounts)
                if !designColoredBackgroundAmounts {
                    Toggle("Colored Amounts", systemImage: "textformat.12", isOn: $designColoredAmounts)
                }
            }
            
            /*
            Section {
                Label("Accent Color", systemImage: "gear")
                CustomColorPicker(selectedColor: $col)
            }
            
            
            Section {
                Picker(selection: $selectedApperance) {
                    Label("System", systemImage: "smartphone")
                        .tag(AppApperance.system)
                    Label("Dark", systemImage: "moon")
                        .tag(AppApperance.dark)
                    Label("Light", systemImage: "sun.min")
                        .tag(AppApperance.light)
                } label: {
                    Label("App Appearance", systemImage: "gear")
                }
                .pickerStyle(InlinePickerStyle())
            }
            */
        }
    }
}

#Preview {
    SettingsLookAndFeelView()
}
