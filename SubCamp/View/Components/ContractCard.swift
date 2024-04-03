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
        HStack {
            Label("", systemImage: contract.systemIcon ?? "gear")
                .font(.title3)
                .labelStyle(.iconOnly)
                .frame(width: 40, height: 40)
                .background(in: Circle())
                .backgroundStyle(contract.getColor().gradient)
            
            VStack(alignment: .leading) {
                Text("\(contract.name)")
                    .font(.system(size: 20))
                    .padding(.bottom, 1.0)
                
                Text("10. Mai")
                    .font(.system(size: 12))
            }
            .padding(.leading, 5)

            Spacer()
            
            VStack {
                Text(formatCurrency(amount: contract.amount, currencyCode: "EUR"))
                    .font(.footnote)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .foregroundColor(.white)
            }
            .background(contract.isExpense ? .red : .green)
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


#Preview {
    ContractCard(contract: Contract(name: "Apple One", currency: "eu_EU", amount: 3500, systemIcon: "gear"))
}
