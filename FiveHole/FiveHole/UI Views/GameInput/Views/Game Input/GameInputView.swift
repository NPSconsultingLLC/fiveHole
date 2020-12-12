//
//  GameInputView.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 11/25/20.
//

import SwiftUI

struct GameInputView: View {
    @State var showSaveGameView = false
    
    var body: some View {
        ZStack {
            NavigationView{
                ZStack {
                    LinearGradient(Color.NPSBackgroundGradientStart)
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        // GADBannerViewController()
                        UserInputView()
                        Spacer()
                    }.blur(radius: showSaveGameView ? 30 : 0)
                    .padding()
                    .navigationBarItems(trailing:
                                            Button("Save") {
                                                self.showSaveGameView.toggle()
                                            })
                    
                }
            }
            
            if showSaveGameView {
                SaveGameView(showSaveGameView: $showSaveGameView,
                             passedGoalsAgainst: Int16(UserInputView().goalsVar), passedTotalShots: 32)
                // .transition(.animation(.easeIn) as! AnyTransition)
            } else {
                SaveGameView(showSaveGameView: $showSaveGameView).hidden()
            }
        }.animation(.spring())
    }
}

//MARK: Previewer
struct GameInputView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameInputView().colorScheme(.dark)
        }
    }
}
