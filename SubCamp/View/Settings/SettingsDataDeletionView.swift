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
            Text("Clicking the button deletes all data in the app and if activated, in iCloud.")
            VStack {
                Button(action: {
                    showAlert = true
                }) {
                    Text("Delete All App Data")
                        .foregroundColor(.red)
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Delete All App Data?"),
                    message: Text("This action will delete all data associated with the app. Are you sure you want to continue?"),
                    primaryButton: .destructive(Text("Delete"), action: {
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
            print("Failed to clear all Country and City data.")
        }
        
        // Delete CloudKit records
        let containers: [CKContainer] = [
            CKContainer.default(),
            .init(identifier: "iCloud.com.benjaminsurrey.subcamp"),
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
