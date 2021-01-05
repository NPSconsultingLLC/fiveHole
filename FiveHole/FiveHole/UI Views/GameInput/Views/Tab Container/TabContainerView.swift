//
//  TabContainerView.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 12/6/20.
//

import SwiftUI

struct TabContainerView: View {
    @State var selectedTab = 0
    @State var showGoalDetailsView = false
    @State var showAddnewGoalie = false
    var body: some View {
        //TODO: update icons
        TabView(selection: $selectedTab) {
            GameInputView(showGoalDetailsView: showGoalDetailsView)
                .tabItem {
                    Image(systemName: "star")
                    Text("Game")
                }
                .tag(0)
            GoalieAddSelectPage(showingAddNewGoalie: showAddnewGoalie)
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Goalies")
                }
                .tag(1)
            //SettingsView()
            toDelete_AdView()
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
