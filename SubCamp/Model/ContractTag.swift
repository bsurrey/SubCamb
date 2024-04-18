//
//  ContractTag.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 18.04.24.
//

import Foundation
import SwiftData

@Model
final class ContractTag {
    var name: String?

    @Relationship(deleteRule: .cascade, inverse: \Contract.tags) var contracts: [Contract]? = [Contract]()
    
    init(name: String?) {
        self.name = name
    }
}
