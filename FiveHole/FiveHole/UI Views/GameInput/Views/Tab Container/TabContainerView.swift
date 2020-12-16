//
//  TabContainerView.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 12/6/20.
//

import SwiftUI

struct TabContainerView: View {
    @State private var selectedTab = 0
    @State var showGoalDetailsView = false
    var body: some View {
        //TODO: update icons
        //TODO: apply style 
        TabView(selection: $selectedTab) {
            GameInputView(showGoalDetailsView: showGoalDetailsView)
                .tabItem {
                    Image(systemName: "star")
                    Text("Game")
                }
                .tag(0)
            GoalieAddSelectPage()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Goalies")
                }
                .tag(1)
            SettingsView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Settings")
                }
                .tag(2)
        }.accentColor(.NPSButtonStart)
        
    }
}

struct TabContainerView_Previews: PreviewProvider {
    static var previews: some View {
        TabContainerView()
    }
}
