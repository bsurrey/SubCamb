//
//  ContractSorting.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 23.03.24.
//

import Foundation

enum ContractSorting: String, Identifiable, CaseIterable {
    case aToZ
    case ztoA
    case latest
    case oldest
    
    var title: String {
        switch self {
            case .aToZ:
                return "A to Z"
            case .ztoA:
                return "Z to A"
            case .latest:
                return "Latest"
            case .oldest:
                return "Oldest"
        }
    }
    
    var sortDescriptor: SortDescriptor<Contract> {
        switch self {
            case .aToZ:
                SortDescriptor(\Contract.name, order: .forward)
            case .ztoA:
                SortDescriptor(\Contract.name, order: .reverse)
            case .latest:
                SortDescriptor(\Contract.timestamp, order: .reverse)
            case .oldest:
                SortDescriptor(\Contract.timestamp, order: .forward)
        }
       
    }
    
    var id: Self { return self }
}
