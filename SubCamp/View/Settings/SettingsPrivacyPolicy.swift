//
//  SettingsPrivacyPolicy.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 04.04.24.
//

import SwiftUI

struct SettingsPrivacyPolicy: View {
    var body: some View {
        Form {
            Text("No data is collected in this application. Everything stays on your device.")
                .font(.body)

            Text("If iCloud is enabled, your data may be stored in iCloud. For more information, please refer to Apple's iCloud Privacy Policy.")
                .font(.body)
                .padding(.bottom, 8)
            
                .navigationTitle("Privacy Policy")
        }
    }
}

#Preview {
    SettingsPrivacyPolicy()
}
