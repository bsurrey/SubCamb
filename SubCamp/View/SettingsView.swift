//
//  SettingsView.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 25.03.24.
//

import SwiftUI

struct SettingsView: View {
    var config: [String: Any]?
    
    @AppStorage("iCloudEnabled") var iCloudEnabled: Bool = false
    @AppStorage("enableFaceid") var enableFaceid: Bool = false
    
    @AppStorage("designIconGradient") var designIconGradient: Bool = false
    @AppStorage("designIconRound") var designIconRound: Bool = false
    
    @AppStorage("defaultCurrency") var defaultCurrency: Bool = false

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
            AppVersionInformationView(
                versionString: AppVersionProvider.appVersion(),
                appIcon: AppIconProvider.appIcon()
            )
            
            List {
                Section {
                    NavigationLink {
                        List {
                            ContractCard(contract: Contract(name: "Cat Food", amount: 10_00, systemIcon: "cat.fill"))
                            
                            Section {
                                Toggle("Icon gradient", systemImage: "paintbrush", isOn: $designIconGradient)
                                
                                
                                Toggle("Round icon", systemImage: "paintbrush", isOn: $designIconRound)
                            }
                        }
                    } label: {
                        Label("Design", systemImage: "paintpalette")
                    }

                }
                
                Section {
                    Toggle("Enable iCloud", systemImage: iCloudEnabled ? "icloud.fill" : "icloud", isOn: $iCloudEnabled)
                    Toggle("Enable Face ID", systemImage: "faceid", isOn: $enableFaceid)
                    Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: Text("Default Currency")) {
                        /*@START_MENU_TOKEN@*/Text("1").tag(1)/*@END_MENU_TOKEN@*/
                        /*@START_MENU_TOKEN@*/Text("2").tag(2)/*@END_MENU_TOKEN@*/
                    }
                }
                
                Section("Your Data") {
                    Text("Privacy Policy")
                    Button("Delete My Data", systemImage: "gear") {
                        
                    }
                }
                
                
                
                Section {
                    Text("Changelog")
                    Text("External Tech")
                }
                
                Section {
                    Text("Contact")
                    Text("Feature Request")
                    Text("Rate on App Store")
                }
            }
        }
    }
}




#Preview {
    SettingsView()
}
