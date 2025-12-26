//
//  GameInputView.swift
//  FiveHole
//
//  Includes goalie net visualization showing where goals went in
//

import SwiftUI
import GoogleMobileAds

struct GameInputView: View {
    @State private var showGoalDetailsView = false
    @State private var showingSaveGameView = false
    
    // Track goal locations for current game
    @State private var currentGameGoalLocations: [GoalLocation] = []
    
    // Track stats for current game
    @State private var savesVar = 0.0
    @State private var goalsVar = 0.0
    
    var body: some View {
        ZStack {
            // Main content with banner
            VStack(spacing: 0) {
                // MAIN CONTENT AREA
                ZStack {
                    LinearGradient(Color.NPSBackgroundGradientStart)
                        .edgesIgnoringSafeArea(.top)
                    
                    VStack(spacing: 15) {
                        UserInputView(
                            showGoalDetailsView: $showGoalDetailsView,
                            savesVar: $savesVar,
                            goalsVar: $goalsVar,
                            goalLocations: $currentGameGoalLocations
                        )
                        
                        // GOALIE NET VISUALIZATION
                        if goalsVar > 0 {
                            GoalieNetVisualization(goalLocations: currentGameGoalLocations)
                                .transition(.scale.combined(with: .opacity))
                        } else {
                            // Placeholder when no goals scored
                            VStack(spacing: 4) {
                                Text("Goal Map")
                                    .font(.caption)
                                    .foregroundColor(.NPSTextColor.opacity(0.5))
                                
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        Color.NPSButtonEnd.opacity(0.3),
                                        style: StrokeStyle(lineWidth: 2, dash: [5, 5])
                                    )
                                    .frame(height: 180)
                                    .overlay(
                                        VStack {
                                            Image(systemName: "target")
                                                .font(.system(size: 40))
                                                .foregroundColor(.NPSTextColor.opacity(0.2))
                                            Text("Score goals to see where they went in")
                                                .font(.caption2)
                                                .foregroundColor(.NPSTextColor.opacity(0.4))
                                                .multilineTextAlignment(.center)
                                        }
                                    )
                                    .padding(.horizontal, 20)
                            }
                            .transition(.opacity)
                        }
                        
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
                    .padding(.bottom, 50) // Space for banner
                }
                
                // AD BANNER - Above tab bar
                StandardBannerAd()
                    .background(Color.black.opacity(0.05))
            }
            
            // OVERLAYS (Goal details and Save game)
            if showGoalDetailsView {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showGoalDetailsView = false
                    }
                
                GoalLocationView(
                    showGoalDetailsView: $showGoalDetailsView,
                    goalLocations: $currentGameGoalLocations
                )
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
                    userScore: String(format: "%.0f", savesVar),
                    opponentScore: String(format: "%.0f", goalsVar)
                )
                .transition(.scale)
            }
        }
        .animation(.spring(), value: showGoalDetailsView)
        .animation(.spring(), value: showingSaveGameView)
        .animation(.spring(), value: goalsVar > 0)
    }
}

struct GameInputView_Previews: PreviewProvider {
    static var previews: some View {
        GameInputView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .preferredColorScheme(.dark)
    }
}
