//
//  GameInputView.swift
//  FiveHole
//
//  Banner positioned ABOVE tab bar (respects safe area)
//

import SwiftUI
import GoogleMobileAds

struct GameInputView: View {
    @State private var showGoalDetailsView = false
    @State private var showingSaveGameView = false
    
    var body: some View {
        ZStack {
            // Main content with banner - NO edgesIgnoringSafeArea on bottom!
            VStack(spacing: 0) {
                // MAIN CONTENT AREA
                ZStack {
                    LinearGradient(Color.NPSBackgroundGradientStart)
                        .edgesIgnoringSafeArea(.top) // Only ignore top safe area
                    
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
                        
                        Spacer()
                    }
                    .blur(radius: showGoalDetailsView || showingSaveGameView ? 30 : 0)
                    .padding()
                    .padding(.bottom, 50) // Add space for banner
                }
                
                // AD BANNER - Sits just above tab bar
                StandardBannerAd()
                    .background(Color.black.opacity(0.05))
            }
            // DON'T ignore safe area at bottom - this pushes banner above tab bar!
            
            // OVERLAYS (Goal details and Save game)
            if showGoalDetailsView {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showGoalDetailsView = false
                    }
                
                GoalLocationView(showGoalDetailsView: $showGoalDetailsView)
                    .transition(.scale)
            }
            
            if showingSaveGameView {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showingSaveGameView = false
                    }
                
                GameReviewView(
                    showingSaveGameView: $showingSaveGameView,
                    userScore: "0",
                    opponentScore: "10"
                )
                .transition(.scale)
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
