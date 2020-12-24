//
//  GameInputView.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 11/25/20.
//

import SwiftUI

struct GameInputView: View {
    @State var showGoalDetailsView = false

    var body: some View {
        ZStack {
                NavigationView{
                    ZStack {
                        LinearGradient(Color.NPSBackgroundGradientStart)
                            .edgesIgnoringSafeArea(.all)
                        VStack{
                            UserInputView(showGoalDetailsView: $showGoalDetailsView)
                            Button(action: {
                                //Save Game Action
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
            
            }.animation(.spring())
        }
}
