//
//  SettingsDataDeletionView.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 04.04.24.
//

import SwiftUI
import CloudKit

struct SettingsDataDeletionView: View {
    @State private var showAlert = false
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        Form {
            VStack {
                Text("Tapping this button will remove all data stored within the application, including records stored in iCloud if enabled.")
                    .padding(.bottom)
                Button(action: {
                    showAlert = true
                }) {
                    Text("Delete all app data")
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Data deletion")
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Are You Sure?"),
                    message: Text("Confirming this action will permanently delete all data associated with this app. This action cannot be undone."),
                    primaryButton: .destructive(Text("Confirm Delete"), action: {
                        deleteAllAppData()
                    }),
                    secondaryButton: .cancel()
                )
            }
        }
    }
    
    private func deleteAllAppData() {
        // Implement your logic to delete all app data here
        // This could involve removing user defaults, cached files, user-generated content, etc.
        
        // For example:
        UserDefaults.standard.removeObject(forKey: "yourKey")
        // You may also want to delete files from the app's document directory or other directories if applicable
        
        do {
            try modelContext.delete(model: Contract.self)
        } catch {
            print("Failed to clear all data.")
        }
        
        // Delete CloudKit records
        let containers: [CKContainer] = [
            CKContainer.default(),
            .init(identifier: "iCloud.com.benjaminsurrey.contracts"),
        ]
        
        for container in containers {
            container.privateCloudDatabase.fetchAllRecordZones { zones, error in
                guard let zones = zones, error == nil else {
                    print("Error fetching zones.")
                    return
                }
                
                let zoneIDs = zones.map { $0.zoneID }
                let deletionOperation = CKModifyRecordZonesOperation(recordZonesToSave: nil, recordZoneIDsToDelete: zoneIDs)
                
                deletionOperation.modifyRecordZonesCompletionBlock = { _, deletedZones, error in
                    guard error == nil else {
                        let error = error!
                        
                        print("Error deleting records.", error)
                        return
                    }
                    
                    
                    print("Records successfully deleted in this zone.")
                }
                
                container.privateCloudDatabase.add(deletionOperation)
            }
        }
        
        // After data deletion, you may also want to perform additional cleanup or actions
        
        // Optionally, you can show a confirmation message
        // e.g., showAlert = true
    }
}

#Preview {
    SettingsDataDeletionView()
        .modelContainer(for: Contract.self, inMemory: true)
}
