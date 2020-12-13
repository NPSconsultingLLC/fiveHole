//
//  GoalLocationView.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 11/25/20.
//

import SwiftUI

enum GoalLocation {
    case topLeft
    case topRight
    case middleLeft
    case middleRight
    case bottomLeft
    case bottomMiddle
    case bottmRight
}

struct GoalLocationView: View {
    @State private var isToggled           = false
    @State private var topLeftIsOn         = false
    @State private var topRightIsOn        = false
    @State private var middleLeftIsOn      = false
    @State private var middleRightIsOn     = false
    @State private var bottomLeftIsOn      = false
    @State private var bottomMiddleIsOn    = false
    @State private var bottomRightIsOn     = false
    
    @State var showGoalLocationView = false
    
    var body: some View {
        ZStack {
            LinearGradient(Color.NPSBackgroundGradientStart)
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                HStack {
                    VStack {
                        Toggle(isOn: $topLeftIsOn) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.white)
                        }
                        .toggleStyle(ColorfulToggleStyle())
                        Text("Top Left")
                            .foregroundColor(Color("NPSTextColor"))
                    }
                    Spacer()
                    VStack {
                        Toggle(isOn: $topRightIsOn) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.white)
                        }
                        .toggleStyle(ColorfulToggleStyle())
                        Text("Top Right")
                            .foregroundColor(Color("NPSTextColor"))
                    }
                }
                Spacer()
                HStack {
                    VStack {
                        Toggle(isOn: $middleLeftIsOn) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.white)
                        }
                        .toggleStyle(ColorfulToggleStyle())
                        Text("Middle Left")
                            .foregroundColor(Color("NPSTextColor"))
                    }
                    Spacer()
                    VStack {
                        Toggle(isOn: $middleRightIsOn) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.white)
                        }
                        .toggleStyle(ColorfulToggleStyle())
                        Text("Middle Right")
                            .foregroundColor(Color("NPSTextColor"))
                    }
                }
                Spacer()
                HStack {
                    VStack {
                        Toggle(isOn: $bottomLeftIsOn) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.white)
                        }
                        .toggleStyle(ColorfulToggleStyle())
                        Text("Bottom Left")
                            .foregroundColor(Color("NPSTextColor"))
                    }
                    Spacer()
                    VStack {
                        Toggle(isOn: $bottomMiddleIsOn) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.white)
                        }
                        .toggleStyle(ColorfulToggleStyle())
                        Text("Bottom Middle")
                            .foregroundColor(Color("NPSTextColor"))
                    }
                    Spacer()
                    VStack {
                        Toggle(isOn: $bottomRightIsOn) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.white)
                        }
                        .toggleStyle(ColorfulToggleStyle())
                        Text("Bottom Right")
                            .foregroundColor(Color("NPSTextColor"))
                    }
                }
            }.padding()
            VStack{
                HStack{
                    Button(action: {
                        self.showGoalLocationView.toggle()
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    }){
                        Text("Save")
                            .foregroundColor(.NPSTextColor)
                            .minimumScaleFactor(0.01)
                            .scaledToFill()
                            .lineLimit(1)
                        
                    }.buttonStyle(ColorfulButtonStyle())
                }
                HStack{
                    Button(action: {
                        self.showGoalLocationView.toggle()
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    }){
                        Text("Dismiss")
                            .foregroundColor(.NPSTextColor)
                            .minimumScaleFactor(0.01)
                            .scaledToFill()
                            .lineLimit(1)
                        
                    }.buttonStyle(ColorfulButtonStyle())
                }
                .padding()
                Spacer()
            }
           
        }
    }
}

struct GoalLocationView_Previews: PreviewProvider {
    static var previews: some View {
        GoalLocationView().colorScheme(.dark)
    }
}
