//
//  Contract.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 15.03.24.
//

import Foundation
import SwiftData

enum ContractType: Codable {
    case expense, income
}

@Model
final class Contract {
    var name: String
    var note: String?
    var currency: String?
    var amount: Int
    var firstPayment: Data?
    var timestamp: Date
    var type: ContractType
    
    init(name: String, note: String? = nil, currency: String? = "EUR", amount: Int, firstPayment: Data? = nil, timestamp: Date = Date(), type: ContractType = .expense) {
        self.name = name
        self.note = note
        self.currency = currency
        self.amount = amount
        self.firstPayment = firstPayment
        self.timestamp = timestamp
        self.type = type
    }
    
    // Helper method to get the Locale object from the currency string
    func getCurrencyLocale() -> Locale? {
        guard let currencyIdentifier = self.currency else { return nil }
        return Locale(identifier: currencyIdentifier)
    }
}
