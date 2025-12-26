//
//  SettingsView.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 12/6/20.
//

import SwiftUI
import MessageUI

struct SettingsView: View {
    
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    
    var body: some View {
        NavigationView {
            List{
                NavigationLink(destination: SettingsDetailView(detailView: .removeAds )) {
                    Text("Remove Ads")
                }
                NavigationLink(destination: SettingsDetailView(detailView: .credits)) {
                    Text("Credits")
                }
                Button(action: {
                    self.isShowingMailView.toggle()
                }, label: {
                    HStack {
                        Text("Contact Support")
                        Spacer()
                        Image(systemName: "envelope.badge.fill")
                    }
                })
            }
            .navigationBarTitle("Settings")
        }.sheet(isPresented: $isShowingMailView) {
            MailView(isShowing: self.$isShowingMailView, result: self.$result)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
