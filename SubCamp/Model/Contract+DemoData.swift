//
//  Contract+DemoData.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 04.04.24.
//

import Foundation
import SwiftUI

extension Contract {
    static let demoIncome = Contract(name: "Income", currency: "EUR", amount: 1_200, isExpense: false, systemIcon: "creditcard", red: Color.blue.toRGB().red, green: Color.blue.toRGB().green, blue: Color.blue.toRGB().blue)
    
    static let demoExpense = Contract(name: "Cat food", currency: "EUR", amount: 14_99, isExpense: true, systemIcon: "cat", red: Color.green.toRGB().red, green: Color.green.toRGB().green, blue: Color.green.toRGB().blue)
}
