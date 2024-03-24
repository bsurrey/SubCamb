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
        VStack {
            HStack {
                Text("Income")
                
                Spacer()
                
                Text(formatCurrency(amount: income, currencyCode: "EUR"))
            }
            
            HStack {
                Text("Expenses")
                
                Spacer()
                
                Text(formatCurrency(amount: expenses, currencyCode: "EUR"))
            }
            
            HStack {
                Text("Left")
                
                Spacer()
                
                Text(formatCurrency(amount: total, currencyCode: "EUR"))
            }
        }
    }
}


#Preview {
    Total(contracts: [Contract(name: "test", amount: 7237)])
}
