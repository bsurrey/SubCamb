//
//  CreateEditView.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 16.03.24.
//

import SwiftUI
import SwiftData


struct CreateEditView: View {
    let contract: Contract? = nil
    
    private var editorTitle: String {
        contract == nil ? "New Contract" : "Edit Contract"
    }
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    // Info
    @State private var name: String = ""
    @State private var note: String = ""
    @State private var url: String = ""
    @State private var firstPayment: Date = Date()
    @State private var amount: Int = 0
    @State private var chosenLocale = Locale(identifier: "eu_EU")
    
    private var formatter: NumberFormatter {
        let fmt = NumberFormatter()
        fmt.numberStyle = .currency
        fmt.minimumFractionDigits = 2
        fmt.maximumFractionDigits = 2
        fmt.locale = chosenLocale
        return fmt
    }
    
    private let locales = [
        Locale(identifier: "eu_EU"),
        Locale(identifier: "us_US"),
        Locale(identifier: "ja_JP"),
        Locale(identifier: "gb_GB"),
    ]
    
    @State private var selectedContractType: ContractType = .expense
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .font(.title)
                    .multilineTextAlignment(.center)
                
                Section(content: {
                    Picker("Contract Type", selection: $selectedContractType) {
                        Text("Expense").tag(ContractType.expense)
                        Text("Income").tag(ContractType.income)
                    }
                    
                })
                
                Section(content: {
                    Picker(selection: $chosenLocale) {
                        ForEach(locales, id: \.self) {
                            if let cc = $0.currency?.identifier, let sym = $0.currencySymbol {
                                Text("\(cc) \(sym)")
                            }
                        }
                    } label: {
                        Text("Currency")
                    }
                    
                    HStack {
                        Text("Amount")
                        
                        Spacer()
                        
                        CurrencyField(value: $amount, formatter: formatter)
                    }
                })
                
                Section {
                    DatePicker("First Payment", selection: $firstPayment, displayedComponents: [.date])
                    
                    TextField("URL", text: $url)
                    
                    ZStack(alignment: .topLeading) {
                        if note.isEmpty {
                            Text("Enter your notes here...")
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                                .padding(.leading, 5)
                        }
                        TextEditor(text: $note)
                            .opacity(note.isEmpty ? 0.25 : 1) // Adjust opacity if needed
                            .frame(minHeight: 60) // Adjust the size as needed
                    }
                }
                
            }
            .navigationBarTitle("", displayMode: .inline) // the title can be empty string if needed

            
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                    .disabled(name == "")
                }
            }
            .onAppear {
                if let contract {
                    name = contract.name
                }
            }
            
        }
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    private func save() {
        withAnimation {
            if contract != nil {
                // TODOD: editing
            } else {
                let newContract = Contract(
                    name: name, currency: chosenLocale.identifier, amount: amount, timestamp: Date(), isExpense: selectedContractType == ContractType.expense
                )
                modelContext.insert(newContract)
            }
        }
    }
}

#Preview("Add Contract") {
    CreateEditView()
        .modelContainer(for: Contract.self, inMemory: true)
}
