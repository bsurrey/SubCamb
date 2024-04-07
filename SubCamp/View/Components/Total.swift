//
//  Total.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 18.03.24.
//

import SwiftUI
import SwiftData

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
                    .labelStyle(ColorfulIconLabelStyle(.green))
                                
                Spacer()
                
                Text(formatCurrency(amount: income, currencyCode: "EUR"))
            }
            .padding(.bottom, 6.0)

            
            HStack {
                Label("Expenses", systemImage: "minus")
                    .labelStyle(ColorfulIconLabelStyle(.red))
                                
                Spacer()
                
                Text(formatCurrency(amount: expenses, currencyCode: "EUR"))
            }
            
            Divider()
                .padding(.bottom, 6.0)
            
            HStack {
                Label("Left", systemImage: "equal")
                    .labelStyle(ColorfulIconLabelStyle(.accentColor))
                
                Spacer()
                
                Text(formatCurrency(amount: total, currencyCode: "EUR"))
            }
        })
        //.textCase(.uppercase)
        .foregroundColor(.primary)
        //.font(.headline)
    }
}


#Preview {
    List {
        Total(contracts: [
            Contract(name: "Cat Food", amount: 2999, isExpense: true),
            Contract(name: "Dog Food", amount: 4999, isExpense: true),
            Contract(name: "Icome", amount: 250000, isExpense: false),
        ])
    }
}
