//
//  Contract.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 15.03.24.
//

import Foundation
import SwiftData
import SwiftUI

enum ContractType: Codable {
    case expense, income
}

@Model
final class Contract {
    var name: String = ""
    var note: String?
    var currency: String?
    var amount: Int = 0
    var firstPayment: Data?
    var timestamp: Date = Date()
    var isExpense: Bool = true
    var systemIcon: String?
    var payDay: Date?
    
    var recurrence: ContractRecurrence?

    var red: Float = Color.blue.toRGB().red
    var green: Float = Color.green.toRGB().green
    var blue: Float = Color.blue.toRGB().blue
    
    var tags: ContractTag?
    
    init(
        name: String,
        note: String? = nil,
        currency: String? = "EUR",
        amount: Int,
        timestamp: Date = Date(),
        isExpense: Bool = true,
        payDay: Date = Date(),
        systemIcon: String? = nil,
        
        red: Float = Color.blue.toRGB().red,
        green: Float = Color.blue.toRGB().green,
        blue: Float = Color.blue.toRGB().blue,
        
        recurrence: ContractRecurrence = .monthly
    ) {
        self.name = name
        self.note = note
        self.currency = currency
        self.amount = amount
        self.timestamp = timestamp
        self.isExpense = isExpense
        self.systemIcon = systemIcon
        self.payDay = payDay
        
        self.recurrence = recurrence
        
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    func getColor() -> Color {
        Color.fromRGB(red: self.red, green: self.green, blue: self.blue)
    }
    
    // Helper method to get the Locale object from the currency string
    func getCurrencyLocale() -> Locale? {
        guard let currencyIdentifier = self.currency else { return nil }
        return Locale(identifier: currencyIdentifier)
    }
}
