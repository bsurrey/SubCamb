//
//  CreateEditView.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 16.03.24.
//

import SwiftUI
import SwiftData
import SymbolPicker


struct CreateEditView: View {
    let contract: Contract?
    
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

    @State private var symbol = "hand.point.up.left.fill"
    @State private var showSymbolPicker = false
    @State private var selectedColor = Color.blue
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        ZStack {
                            Button {
                                showSymbolPicker.toggle()
                            } label: {
                                ContractLabelIcon(symbol: symbol, selectedColor: selectedColor)
                            }
                            .foregroundColor(.white)
                            .sheet(isPresented: $showSymbolPicker) {
                                SymbolPicker(symbol: $symbol, defaultSymbol: "", symbolGroup: getSymbolGroup())
                            }
                        }
                        TextField("Name", text: $name)
                            .font(.title)
                            .padding(.leading)
                    }
                    
                    CustomColorPicker(selectedColor: $selectedColor)
                }
                
                Section(content: {
                    Picker("Contract Type", selection: $selectedContractType) {
                        Text("Expense").tag(ContractType.expense)
                        Text("Income").tag(ContractType.income)
                    }
                    //.pickerStyle(MenuPickerStyle())
                })
                
                Section(content: {
                    Picker(selection: $chosenLocale) {
                        ForEach(locales, id: \.self) {
                            if let cc = $0.currency?.identifier, let sym = $0.currencySymbol {
                                Text("\(cc) \(sym)")
                                    .tag($0.currency?.identifier)
                            }
                        }
                    } label: {
                        Text("Currency")
                    }
                    HStack {
                        Text("Installment")
                        
                        Spacer()
                        
                        CurrencyField(value: $amount, formatter: formatter)
                    }
                })
                
                Section {
                    DatePicker("Monthly Payment day", selection: $firstPayment, displayedComponents: [.date])
                    
                    TextField("URL", text: $url)
                    
                    ZStack(alignment: .topLeading) {
                        if note.isEmpty {
                            Text("Here you can enter a note, like something important...")
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                                .padding(.leading, 5)
                        }
                        TextEditor(text: $note)
                            .opacity(note.isEmpty ? 0.25 : 1)
                            .frame(minHeight: 60)
                    }
                }
                
            }
            .navigationBarTitle("", displayMode: .inline)
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
                    note = contract.note ?? ""
                    firstPayment = contract.payDay ?? Date()
                    amount = contract.amount
                    chosenLocale = Locale(identifier: contract.currency ?? "eu_EU")
                    selectedContractType = contract.isExpense ? .expense : .income
                    symbol = contract.systemIcon ?? "hand.point.up.left.fill"
                    //@State private var url: String = ""
                    selectedColor = contract.getColor()
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
                contract?.name = name
                contract?.amount = amount
                contract?.isExpense = selectedContractType == ContractType.expense
                contract?.currency = chosenLocale.identifier
                contract?.payDay = firstPayment
                contract?.note = note
                contract?.timestamp = Date()
                contract?.systemIcon = symbol
                
                contract?.red = selectedColor.toRGB().red
                contract?.green = selectedColor.toRGB().green
                contract?.blue = selectedColor.toRGB().blue
            } else {
                let newContract = Contract(
                    name: name,
                    currency: chosenLocale.identifier,
                    amount: amount, 
                    timestamp: Date(),
                    isExpense: selectedContractType == ContractType.expense,
                    systemIcon: symbol,
                    red: selectedColor.toRGB().red,
                    green: selectedColor.toRGB().green,
                    blue: selectedColor.toRGB().blue
                )
                modelContext.insert(newContract)
            }
        }
    }
}

#Preview("Add Contract") {
    CreateEditView(contract: nil)
        .modelContainer(for: Contract.self, inMemory: true)
}
