//
//  ListView.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 15.03.24.
//

import SwiftUI
import SwiftData

struct ListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var contracts: [Contract]
    @State private var isEditorPresented = false
    
    @State private var income: Int = 0
    @State private var expenses: Int = 0
    @State private var total: Int = 0
    
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    Total(contracts: contracts, income: income, total: total, expenses: expenses)
                    
                    List {
                        ForEach(contracts) { contract in
                            ContractCard(contract: contract)
                                .listRowSeparator(.hidden)
                                .background(.clear)
                                .listRowBackground(
                                    RoundedRectangle(cornerRadius: 8)
                                    //.background(.clear)
                                        .fill(Material.regular) // Use the .fill modifier with Material
                                        //.foregroundColor(.gray)
                                        .padding(
                                            EdgeInsets(
                                                top: 4,
                                                leading: 0,
                                                bottom: 4,
                                                trailing: 0
                                            )
                                        )
                                )
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
                
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Menu("test", systemImage: "line.3.horizontal.decrease.circle") {
                            Section {
                                Button("Duplicate", action: addContract)
                                Button("Rename", action: addContract)
                                Button("Delete…", action: addContract)
                            }
                            
                            
                            Section {
                                Button("Duplicate", action: addContract)
                                Button("Rename", action: addContract)
                                Button("Delete…", action: addContract)
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
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            VStack {
                Text("hajsdh")
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
        }
        .onAppear(perform: {
            addContract()
            
            total = calculateTotalIncome(contracts: contracts)
            expenses = calculateExpenses(contracts: contracts)
            income = calculateIncome(contracts: contracts)
        })
    }
    
    private func addContract() {
        withAnimation {
            let newItem = Contract(name: "Apple One", amount: 1020)
            modelContext.insert(newItem)
            
            let secondItem = Contract(name: "Netflix", amount: 1020)
            modelContext.insert(secondItem)
            
            let thirdItem = Contract(name: "Disney+", amount: 150)
            modelContext.insert(thirdItem)
        }
    }
    
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(contracts[index])
            }
        }
    }
}

#Preview {
    ListView()
        .modelContainer(for: Contract.self, inMemory: true)
}
