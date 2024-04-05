//
//  ContractRepeater.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 06.04.24.
//

import Foundation
import SwiftData

enum ContractRecurrence: String, Codable, CaseIterable {
    case daily
    case everyTwoDays
    case weekly
    case everyTwoWeeks
    case monthly
    case everyThreeMonths
    case everySixMonths
    case yearly
    
    var description: String {
        switch self {
            case .daily: return "Daily"
            case .everyTwoDays: return "Every Two Days"
            case .weekly: return "Weekly"
            case .everyTwoWeeks: return "Every Two Weeks"
            case .monthly: return "Monthly"
            case .everyThreeMonths: return "Every Three Months"
            case .everySixMonths: return "Every Six Months"
            case .yearly: return "Yearly"
        }
    }
}
