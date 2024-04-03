//
//  AppVersionInformationView.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 03.04.24.
//

import SwiftUI

struct AppVersionInformationView: View {
    let versionString: String
    let appIcon: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            // App icons can only be retrieved as named `UIImage`s
            // https://stackoverflow.com/a/62064533/17421764
            if let image = UIImage(named: appIcon) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 1)
            }
                        
            VStack(alignment: .leading) {
                Text("Version")
                    .bold()
                
                Text("v\(versionString)")
                    .multilineTextAlignment(.center)
            }
            .multilineTextAlignment(.center)
            .font(.caption)
            .foregroundColor(.primary)
        }
        .fixedSize()
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("App version \(versionString)")
    }
}

#Preview {
    AppVersionInformationView(
        versionString: AppVersionProvider.appVersion(),
        appIcon: AppIconProvider.appIcon()
    )
}
