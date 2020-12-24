//
//  SettingsView.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 12/6/20.
//

import SwiftUI

struct SettingsView: View {

    var body: some View {
        NavigationView {
            List{
                NavigationLink(destination: SettingsDetailView(detailView: .removeAds )) {
                    Text("Remove Ads")
                }
                NavigationLink(destination: SettingsDetailView()) {
                    Text("Contact Support")
                }
                NavigationLink(destination: SettingsDetailView(detailView: .credits)) {
                    Text("Credits")
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
