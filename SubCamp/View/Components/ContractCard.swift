//
//  ContractCard.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 18.03.24.
//

import SwiftUI

struct ContractCard: View {
    var contract: Contract
    @AppStorage("designColoredBackgroundAmounts") var designColoredBackgroundAmounts: Bool = true
    @AppStorage("designColoredAmounts") var designColoredAmounts: Bool = true
    @Environment(\.colorScheme) var colorScheme


    var body: some View {
        HStack {
            ContractLabelIcon(symbol: contract.systemIcon ?? "exclamationmark.triangle.fill", selectedColor: contract.getColor(), size: 48, font: .title3)
            
            VStack(alignment: .leading) {
                Text("\(contract.name)")
                    .font(.system(size: 20))
                    .padding(.bottom, 1.0)

                if contract.payDay != nil {
                    Text("\(contract.payDay ?? Date(), format: Date.FormatStyle(date: .abbreviated, time: .none))")
                        .font(.system(size: 12))
                }
            }
            .padding(.leading, 8)

            Spacer()
            
            VStack {
                Text(formatCurrency(amount: contract.amount, currencyCode: "EUR"))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .foregroundColor(
                        (designColoredBackgroundAmounts ? .white : (
                            designColoredAmounts ?
                                (contract.isExpense ? .red : .green) :
                                    (colorScheme == .dark ? .white : .black)
                                )
                        )
                    )
            }
            .background(designColoredBackgroundAmounts ? contract.isExpense ? .red : .green : .clear)
            .cornerRadius(8)
        }
    }
}


#Preview {
    ContractCard(contract: Contract(name: "Apple One", currency: "eu_EU", amount: 3500, systemIcon: "gear"))
}
