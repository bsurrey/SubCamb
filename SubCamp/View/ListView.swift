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
    
    @State var isEditorPresented: Bool
    
    @Query var contracts: [Contract]
    
    @Query(filter: #Predicate<Contract>{contract in
        contract.isExpense == true
    }, animation: .smooth) var contractsExpenses: [Contract]
    
    @Query(filter: #Predicate<Contract>{contract in
        contract.isExpense == false
    }, animation: .smooth) var contractsIncomes: [Contract]
    
    @AppStorage("groupByType") var groupByType: Bool = true
    @AppStorage("contractSorting") var contractSorting: ContractSorting = .aToZ
    
    @State var sortByNameDesc: Bool = true
    //@State private var contractSorting = ContractSorting.ztoA
    let searchTerm: String
    
    init(
        searchTerm: String,
        sorting: ContractSorting,
        isEditorPresented: Bool,
        groupByType: Bool
    ) {
        self.searchTerm = searchTerm
        self.isEditorPresented = isEditorPresented
        self.groupByType = groupByType
        
        if searchTerm.count > 0 {
            self._contracts = Query(filter: #Predicate<Contract> {
                $0.name.contains(searchTerm)
            }, sort: [sorting.sortDescriptor], animation: .easeInOut)
            
            self._contractsIncomes = Query(filter: #Predicate<Contract> {
                $0.isExpense == false && $0.name.contains(searchTerm)
            }, sort: [sorting.sortDescriptor], animation: .easeInOut)
            
            // MARK: Expenses
            self._contractsExpenses = Query(filter: #Predicate<Contract> {
                $0.isExpense == true && $0.name.contains(searchTerm)
            }, sort: [sorting.sortDescriptor], animation: .easeInOut)
        } else {
            self._contracts = Query(sort: [sorting.sortDescriptor], animation: .easeInOut)
            
            self._contractsIncomes = Query(
                filter: #Predicate<Contract>{contract in
                    contract.isExpense == false
                },
                sort: [sorting.sortDescriptor], 
                animation: .easeInOut
            )
            self._contractsExpenses = Query(
                filter: #Predicate<Contract>{contract in
                    contract.isExpense == true
                },
                sort: [sorting.sortDescriptor], 
                animation: .easeInOut
            )
        }
    }

    
    var body: some View {
        VStack(spacing: 0) {
            List {
                if groupByType {
                    if contractsIncomes.count > 0 {
                        Section("Incomes") {
                            ForEach(contractsIncomes) { i in
                                ContractCard(contract: i)
                            }
                            .onDelete(perform: deleteItems)
                        }
                    }
                    
                    if contractsExpenses.count > 0 {
                        Section("Expenses") {
                            ForEach(contractsExpenses) { x in
                                ContractCard(contract: x)
                            }
                            .onDelete(perform: deleteItems)
                        }
                    }
                } else {
                    ForEach(contracts) { c in
                        ContractCard(contract: c)
                    }
                    .onDelete(perform: deleteItems)
                }
            }
        }
    }
    
    private func addContract() {
        withAnimation {
            let newItem = Contract(name: "Apple One", amount: 1020, isExpense: false)
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
    MainView()
        .modelContainer(for: Contract.self, inMemory: true)
}
