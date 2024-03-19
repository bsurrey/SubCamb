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
        HStack {
            VStack {
                Text("Income")
                
                
                Text(formatCurrency(amount: income, currencyCode: "EUR"))
            }
            
            Spacer()
            
            VStack {
                Text("Expenses")
                
                
                Text(formatCurrency(amount: expenses, currencyCode: "EUR"))
            }
            
            Spacer()
            
            VStack {
                Text("Total")
                
                
                Text(formatCurrency(amount: total, currencyCode: "EUR"))
            }
        }
        .padding()

        .background(
            RoundedRectangle(cornerRadius: 8)
                 //.background(.clear)
                .fill(Material.thin) // Use the .fill modifier with Material
                //.foregroundColor(.gray)
        )
        .padding()
    }
}


#Preview {
    Total(contracts: [Contract(name: "test", amount: 7237)], income: 372, total: 8238, expenses: 9238)
}
