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
    
    var income: Int
    var total: Int
    var expenses: Int
    
    var body: some View {
        VStack {
            Text("Montly")
                .font(.footnote)
                .padding(.bottom, 5.0)
            
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
    Total(contracts: [Contract(name: "test", amount: 7237)], income: 372, total: 8238, expenses: 9238)
}
