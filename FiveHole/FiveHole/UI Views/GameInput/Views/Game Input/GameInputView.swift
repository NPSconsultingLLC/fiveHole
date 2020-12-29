//
//  GameInputView.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 11/25/20.
//

import SwiftUI

struct GameInputView: View {
    @State var showGoalDetailsView = false
    @State var showingSaveGameView = false
    
    var body: some View {
        ZStack {
            NavigationView{
                ZStack {
                    LinearGradient(Color.NPSBackgroundGradientStart)
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        UserInputView()
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
                        
                    }.blur(radius: showGoalDetailsView ? 30 : 0)
                    .padding()
                }
            }
            if showGoalDetailsView {
                GoalLocationView(showGoalDetailsView: $showGoalDetailsView)
            } else {
                GoalLocationView(showGoalDetailsView: $showGoalDetailsView).hidden()
            }
            
            if showingSaveGameView {
                GameReviewView(showingSaveGameView: $showingSaveGameView, userScore: "0", opponentScore: "10")
            } else {
                GameReviewView(showingSaveGameView:  $showingSaveGameView, userScore: "0", opponentScore: "10")
.hidden()
            }
            
        }.animation(.spring())
    }
}

struct GameInputView_Previews: PreviewProvider {
    static var previews: some View {
        GameInputView()
    }
}
