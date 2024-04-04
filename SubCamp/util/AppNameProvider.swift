//
//  AppNameProvider.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 04.04.24.
//

import Foundation

enum AppNameProvider {
    static func appName(in bundle: Bundle = .main) -> String {
        guard let name = bundle.object(forInfoDictionaryKey: "CFBundleName") as? String else {
            fatalError("CFBundleName should not be missing from info dictionary")
            
        }
        return name
    }
}
