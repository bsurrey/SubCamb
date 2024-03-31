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
    @State private var isShowingSheet = false
    
    @Environment(\.presentationMode) var presentationMode
    
    
    // Function to delete the contract
    private func deleteContract() {
        
        let context = contract.modelContext
        
        print(context)
        
        if let context = contract.modelContext {
            context.delete(contract)
        }
        presentationMode.wrappedValue.dismiss()
        
    }
    
    var body: some View {
        HStack {
            List {
                Text("Hello, World!")
                
            }
            .navigationTitle(contract.name)
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
