//
//  GameInputView.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 11/25/20.
//

import SwiftUI

struct GameInputView: View {
    //@Binding var showGoalLocationView: Bool
    @State var showGoalLocationView = false

    //TODO: Make the add goal location view disiss properly 
    var body: some View {
        ZStack {
                NavigationView{
                    ZStack {
                        LinearGradient(Color.NPSBackgroundGradientStart)
                            .edgesIgnoringSafeArea(.all)
                        VStack{
                            UserInputView(showSaveGoalView: $showGoalLocationView)
                        }.blur(radius: showGoalLocationView ? 30 : 0)
                        .padding()
                        .navigationBarItems(trailing:
                                                Button("Save") {
                                                    //Toggle saving the whole game
                                                })
                    }
                }
                if showGoalLocationView {
                    SaveGoalView()
                } else {
                    SaveGoalView().hidden()
                }
            
            }.animation(.spring())
        }
}

////MARK: Previewer
struct GameInputView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameInputView(showGoalLocationView: true).colorScheme(.dark)
        }
    }
}
