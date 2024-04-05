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
                Toggle(isOn: $designIconGradient, label: {
                    Label("Icon gradient", systemImage: "slider.horizontal.3")
                        .labelStyle(ColorfulIconLabelStyle(.indigo))
                })
                Toggle(isOn: $designIconRound, label: {
                    Label("Round icon", systemImage: designIconRound ? "circle.fill" : "circle")
                        .labelStyle(ColorfulIconLabelStyle(.indigo))
                })
                Toggle(isOn: $designColoredBackgroundAmounts, label: {
                    Label("Colored Backgrounds for Amounts", systemImage: designColoredBackgroundAmounts ? "rectangle.fill" :  "rectangle")
                        .labelStyle(ColorfulIconLabelStyle(.indigo))
                })
                if !designColoredBackgroundAmounts {
                    Toggle(isOn: $designColoredAmounts, label: {
                        Label("Colored Amounts", systemImage: "textformat.12")
                            .labelStyle(ColorfulIconLabelStyle(.indigo))
                    })
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
