//
//  ContractCard.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 18.03.24.
//

import SwiftUI

struct ContractCard: View {
    var contract: Contract
    
    var body: some View {
        NavigationLink {
            Text("Item at \(contract.name)")
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(contract.name)")
                        .font(.system(size: 20))
                        .padding(.bottom, 1.0)
                    
                    Text("10. Mai")
                        .font(.system(size: 12))
                }
                
                Spacer()
                
                VStack {
                    Text(formatCurrency(amount: contract.amount, currencyCode: "EUR"))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .foregroundColor(.white)
                }
                .background(contract.type == ContractType.expense ? .red : .green)
                .cornerRadius(8)
            }
            .padding(
                EdgeInsets(
                    top: 8,
                    leading: 0,
                    bottom: 8,
                    trailing: 0
                )
            )
            
        }
    }
}
