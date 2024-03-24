//
//  MainView.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 24.03.24.
//

import SwiftUI

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var contractSorting = ContractSorting.aToZ
    @State private var searchTerm: String = ""
    
    @State private var isEditorPresented = false
    @State var groupByType: Bool = true

    var body: some View {
        NavigationStack {
            ListView(searchTerm: searchTerm, sorting: contractSorting, isEditorPresented: isEditorPresented, groupByType: groupByType)
                .searchable(text: $searchTerm)
                .navigationTitle("Contracts")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Menu("test", systemImage: "line.3.horizontal.decrease.circle") {
                            Section(header: Text("Grouping"), content: {
                                Toggle("Group by Type", isOn: $groupByType)
                            })
                            
                            Picker(selection: $contractSorting.animation()) {
                                ForEach(ContractSorting.allCases) { tag in
                                    Text(tag.title)
                                }
                            } label: {
                                Text("Sort Tags by")
                            }
                        }
                        .menuStyle(ButtonMenuStyle())
                    }
                    ToolbarItem(placement: .primaryAction) {
                        Button("Add", systemImage: "plus") {
                            isEditorPresented = true
                        }
                    }
                    
                    ToolbarItem(placement: .automatic) {
                        EditButton()
                    }
                }
                .sheet(isPresented: $isEditorPresented) {
                    CreateEditView()
                }
        }
    }
}

#Preview {
    MainView()
        .modelContainer(for: Contract.self, inMemory: true)

}
