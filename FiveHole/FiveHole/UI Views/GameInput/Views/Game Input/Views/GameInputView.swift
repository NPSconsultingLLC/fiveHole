//
//  GameInputView.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 11/25/20.
//  Updated for iOS 15+ and Google Mobile Ads SDK 11.x - 12/26/24
//

import SwiftUI
import GoogleMobileAds

struct GameInputView: View {
    @State private var showGoalDetailsView = false
    @State private var showingSaveGameView = false
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    // ✅ Modern ad implementation (Option 1: Using the new AdBannerView)
                    // Uncomment this line if you've added AdBannerView.swift to your project:
                     StandardBannerAd()
                    
                    // ✅ Or use the fixed adView (Option 2: Keep using toDelete_AdView.swift)
                    //adView()
                    
                    LinearGradient(Color.NPSBackgroundGradientStart)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        UserInputView(showGoalDetailsView: $showGoalDetailsView)
                        
                        Button(action: {
                            showingSaveGameView.toggle()
                        }) {
                            Text("Save Game")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .font(.system(size: 18))
                                .padding()
                                .foregroundColor(.NPSButtonEnd)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.NPSButtonEnd, lineWidth: 2)
                                )
                        }
                    }
                    .blur(radius: showGoalDetailsView || showingSaveGameView ? 30 : 0)
                    .padding()
                }
            }
            
            // Goal details overlay
            if showGoalDetailsView {
                GoalLocationView(showGoalDetailsView: $showGoalDetailsView)
            }
            
            // Save game overlay
            if showingSaveGameView {
                GameReviewView(
                    showingSaveGameView: $showingSaveGameView,
                    userScore: "0",
                    opponentScore: "10"
                )
            }
        }
        .animation(.spring(), value: showGoalDetailsView)
        .animation(.spring(), value: showingSaveGameView)
    }
}

struct GameInputView_Previews: PreviewProvider {
    static var previews: some View {
        GameInputView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .preferredColorScheme(.dark)
    }
}
