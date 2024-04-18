//
//  Total.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 18.03.24.
//

import SwiftUI
import SwiftData

struct PlainGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading,spacing: 8) {
            configuration.label
            HStack {
                Spacer()
                configuration.content
            }
        }
        .padding(8)
        .background(Color(.systemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

struct Total: View {
    var contracts: [Contract]
    
    var total: Int {
        calculateTotalIncome(contracts: contracts)
    }
    
    var expenses: Int {
        calculateExpenses(contracts: contracts)
    }
    
    var income: Int {
        calculateIncome(contracts: contracts)
    }
    
    var body: some View {
        VStack(content: {
            HStack {
                Label("Income", systemImage: "plus")
                    .tint(.green)
                    .labelStyle(ColorfulIconLabelStyle(.green))
                    .symbolRenderingMode(.hierarchical)
                
                Spacer()
                
                Text(formatCurrency(amount: income, currencyCode: "EUR"))
            }
            
            HStack {
                Label("Expenses", systemImage: "minus")
                    .labelStyle(ColorfulIconLabelStyle(.red))
                
                Spacer()
                
                Text(formatCurrency(amount: expenses, currencyCode: "EUR"))
            }
            .padding(.top, 4.0)

            HStack {
                Label("Total", systemImage: "equal")
                    .labelStyle(ColorfulIconLabelStyle(.accentColor))
                
                Spacer()
                
                Text(formatCurrency(amount: total, currencyCode: "EUR"))
                    .bold()
            }
            .padding(.top, 4.0)
        })
        .padding()
    }
}


#Preview {
    List {
        Section {
            Total(contracts: [
                Contract(name: "Cat Food", amount: 2999, isExpense: true),
                Contract(name: "Dog Food", amount: 4999, isExpense: true),
                Contract(name: "Icome", amount: 250000, isExpense: false),
            ])
            .listRowInsets(EdgeInsets())
        }
    }
}
