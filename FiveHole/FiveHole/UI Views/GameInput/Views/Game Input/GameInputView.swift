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
                        }.blur(radius: showGoalDetailsView ? 30 : 0)
                        .padding()
                        .navigationBarItems(trailing:
                                                Button("Save") {
                                                    //Toggle saving the whole game
                                                })
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

////MARK: Previewer
//struct GameInputView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            GameInputView(showGoalLocationView: true).colorScheme(.dark)
//        }
//    }
//}
