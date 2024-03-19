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
                Section(content: {
                    TextField("Name", text: $name)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                })
                
                Section(content: {
                    Picker("Contract Type", selection: $selectedContractType) {
                        Text("Expense").tag(ContractType.expense)
                        Text("Income").tag(ContractType.income)
                    }
                    .pickerStyle(PalettePickerStyle())
                    .frame(maxWidth: .infinity) // Make the picker full width
                    //.padding(.all, -10) // Adjust this value to reduce default Form padding
                    .background(Color.clear) // Remove the background
                    
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
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(editorTitle)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                    .disabled(name == "")
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
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
                    name: name, currency: chosenLocale.identifier, amount: amount, timestamp: Date(), type: selectedContractType
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
