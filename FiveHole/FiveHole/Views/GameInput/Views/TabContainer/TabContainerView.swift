//
//  TabContainerView.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 12/6/20.
//  Updated for iOS 15+ on 12/26/24
//

import SwiftUI

struct TabContainerView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            GameInputView()
                .tabItem {
                    Label("Game", systemImage: "sportscourt.fill")
                }
                .tag(0)
            
            GoalieAddSelectPage(showingAddNewGoalie: false)
                .tabItem {
                    Label("Goalies", systemImage: "person.3.fill")
                }
                .tag(1)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(2)
        }
        .tint(.NPSButtonStart) // iOS 15+ replacement for accentColor
    }
}

// MARK: - Preview Provider
struct TabContainerView_Previews: PreviewProvider {
    static var previews: some View {
        TabContainerView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .preferredColorScheme(.dark)
    }
}
