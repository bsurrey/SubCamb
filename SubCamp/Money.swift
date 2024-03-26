//
//  Money.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 18.03.24.
//

import Foundation

// Function to format an integer to a currency string with a specified locale
func formatCurrency(amount: Int, currencyCode: String) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = currencyCode
    formatter.locale = Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: currencyCode]))

    // Adjust decimal places and convert the amount based on the currency
    let convertedAmount: Double
    switch currencyCode {
    case "JPY": // Japanese Yen
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        convertedAmount = Double(amount) // Use the amount as is for JPY
    default: // Default to two decimal places
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        convertedAmount = Double(amount) / 100.0 // Convert cents to full currency value
    }
    
    let symbol = formatter.currencySymbol ?? ""
    formatter.positiveSuffix = " \(symbol)"
    formatter.negativeSuffix = " \(symbol)"
    formatter.currencySymbol = "" // Remove the default currency symbol


    if let formattedString = formatter.string(from: NSNumber(value: convertedAmount)) {
        return formattedString
    } else {
        return "Failed to format the number."
    }
}

func calculateTotalIncome(contracts: [Contract]) -> Int {
    var totalIncome = 0
    for contract in contracts {
        if !contract.isExpense {
            totalIncome += contract.amount
        } else {
            totalIncome -= contract.amount
        }
    }
    return totalIncome
}

func calculateExpenses(contracts: [Contract]) -> Int {
    var totalIncome = 0
    for contract in contracts {
        if contract.type == ContractType.expense {
            totalIncome -= contract.amount
        }
    }
    return totalIncome
}

func calculateIncome(contracts: [Contract]) -> Int {
    var totalIncome = 0
    for contract in contracts {
        if contract.type == ContractType.income {
            totalIncome += contract.amount
        }
    }
    return totalIncome
}
