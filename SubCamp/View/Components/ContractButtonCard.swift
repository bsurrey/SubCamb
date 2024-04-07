//
//  ContractButtonCard.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 07.04.24.
//

import SwiftUI

struct ContractButtonCard: View {
    var contract: Contract
    
    @AppStorage("designColoredBackgroundAmounts") var designColoredBackgroundAmounts: Bool = true
    @AppStorage("designColoredAmounts") var designColoredAmounts: Bool = true
    @Environment(\.colorScheme) var colorScheme

    @ScaledMetric(relativeTo: .title2) private var itemSize: CGFloat = 100
    
    // Function to delete the contract
    private func deleteContract() {
        // let context = contract.modelContext
                
        if let context = contract.modelContext {
            context.delete(contract)
        }
        presentationMode.wrappedValue.dismiss()
    } 
    
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showInfoSheet = false
    @State private var userAgreed = false
    @State private var isShowingSheet = false
    
    var body: some View {
        
        VStack(spacing: 8) {
            HStack(alignment: .center) {
                ContractLabelIcon(symbol: contract.systemIcon ?? "exclamationmark.triangle.fill", selectedColor: contract.getColor(), size: 48, font: .callout)

                Text(contract.name)
                        //.font(.title)
                
                Spacer()
                
                HStack(alignment: .top) {
                    Menu(content: {
                        Button(action: {
                            showInfoSheet.toggle()
                        }) {
                            Label("Edit Contract", systemImage: "pencil")
                        }
                        
                        Button(role: .destructive, action: {
                            deleteContract()
                        }) {
                            Label("Delete Contract", systemImage: "trash")
                        }
                    }, label: {
                        Label("Menu", systemImage: "ellipsis.circle.fill")
                            .imageScale(.large)
                            .font(.title2)
                            .tint(contract.getColor())
                            
                    })
                    .menuStyle(.button)
                    .buttonStyle(.borderless)
                }
            }
            HStack {
                Text("04. April")
                    .padding(.vertical, 2)
                    .padding(.horizontal, 10)
                    .frame(minWidth: 8, minHeight: 6)
                    .background(contract.getColor().opacity(0.15))
                    .foregroundColor(contract.getColor())
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                
                Spacer()
                
                VStack {
                    Text("\(contract.isExpense ? "- " : "")\(formatCurrency(amount: contract.amount, currencyCode: "EUR"))")
                        .padding(.vertical, 2)
                        .padding(.horizontal, 10)
                        .frame(minWidth: 8, minHeight: 6)
                        .background(
                            contract.isExpense ? Color.red.opacity(0.15) : Color.green.opacity(0.15)
                        )
                        .foregroundColor(
                            contract.isExpense ? Color.red : Color.green
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
                
            }
            
        }
        .buttonStyle(PlainButtonStyle())
        .tint(.blue)
        //.cornerRadius(8)
        .lineLimit(1)
        .font(.headline)
        .bold()
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
    List {
        ContractButtonCard(contract: Contract(
            name: "Apple One",
            currency: "eu_EU",
            amount: 3500,
            isExpense: false,
            systemIcon: "gear", 
            red: Color.red.toRGB().red,
            green: Color.red.toRGB().green,
            blue: Color.red.toRGB().blue
        ))
        ContractButtonCard(contract: Contract(name: "Apple One", currency: "eu_EU", amount: 3500, systemIcon: "gear"))
    }
}
