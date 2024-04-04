//
//  AppNameProvider.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 03.04.24.
//

import Foundation

enum AppNameProvider {
    static func appName(in bundle: Bundle = .main) -> String {
        guard let version = bundle.object(forInfoDictionaryKey: "CFBundleName") as? String else {
            fatalError("CFBundleName should not be missing from info dictionary")
            
        }
        return version
    }
}
