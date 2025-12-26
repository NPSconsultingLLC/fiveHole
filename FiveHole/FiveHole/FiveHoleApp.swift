//
//  FiveHoleApp.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 11/25/20.
//  Updated for iOS 15+ on 12/26/24
//

import SwiftUI
import Firebase
import GoogleMobileAds

@main
struct FiveHoleApp: App {
    @StateObject private var persistenceController = PersistenceController.shared
    
    init() {
        // Configure Firebase
        FirebaseApp.configure()
        
        // Initialize Google Mobile Ads with completion handler
        MobileAds.shared.start { status in
            print("✅ Google Mobile Ads SDK initialized")
        }
    }

    var body: some Scene {
        WindowGroup {
            TabContainerView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

// MARK: - Preview Provider
struct FiveHoleApp_Previews: PreviewProvider {
    static var previews: some View {
        TabContainerView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
