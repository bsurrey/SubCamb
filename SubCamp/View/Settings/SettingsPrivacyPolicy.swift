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
            Section(header: Text("Data Collection")) {
                Text("We value your privacy and security. All functionalities are performed locally on your device without transmitting data externally, ensuring your complete privacy.")
            }

            Section(header: Text("iCloud Data")) {
                Text("In case iCloud is enabled on your device, your data may be automatically stored in iCloud to facilitate device syncing and data backup. For specific details on how your data is managed in iCloud, please review Apple's official iCloud Privacy Policy.")
            }
        }
        .navigationBarTitle("Privacy Policy", displayMode: .inline)
    }
}


#Preview {
    SettingsPrivacyPolicy()
}
