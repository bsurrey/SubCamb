//
//  SettingsView.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 25.03.24.
//

import SwiftUI

struct SettingsView: View {
    var config: [String: Any]?
            
    init() {
        if let infoPlistPath = Bundle.main.url(forResource: "Info", withExtension: "plist") {
            do {
                let infoPlistData = try Data(contentsOf: infoPlistPath)
                
                if let dict = try PropertyListSerialization.propertyList(from: infoPlistData, options: [], format: nil) as? [String: Any] {
                    config = dict
                }
            } catch {
                print(error)
            }
        }
    }
        
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack {
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
