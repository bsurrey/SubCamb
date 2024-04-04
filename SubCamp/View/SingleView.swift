//
//  SingleView.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 30.03.24.
//

import SwiftUI
import SwiftData

struct SingleView: View {
    @Environment(\.modelContext) private var modelContext
    
    var contract: Contract
    
    @State private var showInfoSheet = false
    @State private var userAgreed = false
    @State private var isShowingSheet = false
    
    private var label: String {
        let mag = pow(10, formatter.maximumFractionDigits)
        return formatter.string(for: Decimal(contract.amount) / mag) ?? ""
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    private var formatter: NumberFormatter {
        let fmt = NumberFormatter()
        fmt.numberStyle = .currency
        fmt.minimumFractionDigits = 2
        fmt.maximumFractionDigits = 2
        fmt.locale = Locale(identifier: contract.currency ?? "eu_EU")
        return fmt
    }
    
    // Function to delete the contract
    private func deleteContract() {
        let context = contract.modelContext
                
        if let context = contract.modelContext {
            context.delete(contract)
        }
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        VStack {
            GroupBox {
                HStack {
                    Spacer()

                    VStack {
                        ContractLabelIcon(symbol: contract.systemIcon ?? "gear", selectedColor: contract.getColor())
                        
                        Text(contract.name)
                            .padding(.leading, 8.0)
                            .font(.title2)
                    }

                    Spacer()
                }
            }
            
            HStack {
                GroupBox(label: Label("Monthly Cost", systemImage: "gear")) {
                    Text("\(label)")
                }
                

                GroupBox(label: Label("Type", systemImage: "info")) {
                    Text(contract.isExpense ? "Expense" : "Income")
                }

            }
            
            
            GroupBox(label:
                    Label("Url", systemImage: "link")
                ) {
                Text(contract.note ?? "No url provided")
                    .font(.footnote)
            }
            
            GroupBox(label:
                    Label("Note", systemImage: "note.text")
                ) {
                Text(contract.note ?? "No note provided")
                    .font(.footnote)
            }
            
            Spacer()
        }
        .padding()

            .navigationTitle(contract.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.browser)
            .toolbar {
                ToolbarItem {
                    Button("Delete", systemImage: "trash") { isShowingSheet.toggle() }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button("Edit", systemImage: "pencil") {
                        showInfoSheet.toggle()
                    }
                }
            }
        .sheet(isPresented: $showInfoSheet) {
            CreateEditView(contract: contract)
        }
        .actionSheet(isPresented: $isShowingSheet) {
            ActionSheet(
                title: Text("Permanently delete this contract?"),
                message: Text("You can't undo this action."),
                buttons:[
                    .destructive(Text("Delete"), action: deleteContract ),
                    .cancel()
                ]
            )}
    }
}

#Preview {
    NavigationStack {
        SingleView(contract: Contract(name: "Apple One", currency: "eu_EU", amount: 3500, systemIcon: "gear"))
    }
        .modelContainer(for: Contract.self, inMemory: true)

}
