//
//  MainView.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 24.03.24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var contractSorting = ContractSorting.aToZ
    @State private var searchTerm: String = ""
    
    @State private var isEditorPresented = false
    @State var groupByType: Bool = true
    
    @Query var contracts: [Contract]

    var body: some View {
        NavigationStack {
            VStack {
                if contracts.isEmpty {
                    ContentUnavailableView {
                        Label("No Contracts availible", systemImage: "info.circle.fill")
                    } description: {
                        
                        Button {
                            isEditorPresented = true
                        } label: {
                            Label("Add a new Contract", systemImage: "plus")
                                .help("By clicking here you can create a Contract")
                        }
                    }
                } else {
                    Section {
                        Total(contracts: contracts)
                            .padding(.all)
                            .background(Material.regular)
                    }
                    .cornerRadius(8)
                    .padding(.all)
                    ListView(searchTerm: searchTerm, sorting: contractSorting, isEditorPresented: isEditorPresented, groupByType: groupByType)
                        .searchable(text: $searchTerm)
                }
            }
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
                        .disabled(contracts.isEmpty)
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
