//
//  SettingsView.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 25.03.24.
//

import SwiftUI

struct SettingsView: View {
    var config: [String: Any]?
    
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage("iCloudEnabled") var iCloudEnabled: Bool = false
    @AppStorage("enableFaceid") var enableFaceid: Bool = false
    
    @AppStorage("defaultCurrencyLocaleIdentifier") var defaultCurrencyLocaleIdentifier: String = "en_EU"

    private let locales = [
        Locale(identifier: "en_EU"), // English with Euro
        Locale(identifier: "us_US"),  // United States Dollar
        Locale(identifier: "ja_JP"),  // Japanese Yen
        Locale(identifier: "gb_GB")   // British Pound Sterling
    ]

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
                    HStack(content: {
                        Spacer()
                        
                        AppVersionInformationView(
                            versionString: AppVersionProvider.appVersion(),
                            appIcon: AppIconProvider.appIcon(),
                            appName: AppNameProvider.appName()
                        )
                        
                        Spacer()
                    })
                }
                .listRowBackground(Color.clear)

                /*
                Section {
                    // Label("iCloud status", systemImage: iCloudEnabled ? "icloud.fill" : "icloud")
                    
                    Toggle(isOn: $enableFaceid, label: {
                        Label("Enable Face ID", systemImage: "faceid")
                            .labelStyle(ColorfulIconLabelStyle(.green))
                    })
                    
                    Picker(selection: $defaultCurrencyLocaleIdentifier) {
                        ForEach(locales, id: \.self) { locale in
                            if let cc = locale.currency?.identifier, let sym = locale.currencySymbol {
                                Text("\(cc) \(sym)")
                                    .tag(cc) // Tagging with currency identifier
                            }
                        }
                    } label: {
                        Label("Default currency", systemImage: "eurosign")
                            .labelStyle(ColorfulIconLabelStyle(.blue))
                    }
                }
                 */
                
                Section {
                    NavigationLink {
                        SettingsLookAndFeelView()
                    } label: {
                        Label("Look & Feel", systemImage: "paintpalette")
                            .labelStyle(ColorfulIconLabelStyle(.indigo))
                    }

                }
                
                Section {
                    NavigationLink(destination: {
                        SettingsPrivacyPolicy()
                    }) {
                        Label("Privacy Policy", systemImage: "hand.raised")
                            .labelStyle(ColorfulIconLabelStyle(.blue))
                    }
                    NavigationLink {
                        SettingsDataExportView()
                    } label: {
                        Label("Data export", systemImage: "square.and.arrow.up")
                            .labelStyle(ColorfulIconLabelStyle(.blue))
                    }
                    NavigationLink {
                        SettingsDataDeletionView()
                    } label: {
                        Label("Delete my data", systemImage: "trash")
                            .labelStyle(ColorfulIconLabelStyle(.red))
                            
                    }.tint(.red)
                }
                
                /*
                Section {
                    Text("Changelog")
                    Text("External Tech")
                }
                
                Section {
                    Text("Contact")
                    Text("Feature Request")
                    Text("Rate on App Store")
                }
                 */
            }
            .toolbar(content: {
                ToolbarItem(id: "Close", placement: .topBarTrailing) {
                    Button(action: {dismiss()}, label: {
                        Label("close", systemImage: "xmark")
                    })
                }
            })
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}




#Preview {
    SettingsView()
}
