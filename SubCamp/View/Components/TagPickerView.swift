//
//  TagPickerView.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 18.04.24.
//

import SwiftUI
import SwiftData

struct TagPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Binding var selectedTags: [ContractTag]?
    @Query var contracgTags: [ContractTag]

    var body: some View {
        List {
            Picker("Tag", selection: $selectedTags) {
                Text("Living")
                    .tag("a")
                Text("Living 2")
                    .tag("b")
            }
            .pickerStyle(InlinePickerStyle())
        }
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button("Cancel", role: .cancel) {
                    dismiss()
                }
            }
            
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Add") {
                    withAnimation {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    TagPickerView(selectedTags: .constant(nil))
        .modelContainer(for: Contract.self, inMemory: true)
}
