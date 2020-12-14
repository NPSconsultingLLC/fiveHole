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
    @State private var redirected   = false
    @State private var penaltyShot  = false
    @State private var overTimeGoal = false
    
    @Binding var showGoalDetailsView: Bool
    
    var body: some View {
        ZStack {
            LinearGradient(Color.NPSBackgroundGradientStart)
                .edgesIgnoringSafeArea(.all)
            Rectangle()
                .fill(LinearGradient(
                    gradient: .init(colors: [Color.NPSBackgroundGradientStart, Color.NPSBackgroundGradientEnd]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .clipped()
            VStack {
                HStack{
                    VStack{
                        Toggle(isOn: $redirected){
                        }
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle(tint: Color.NPSButtonStart))
                        Text("Redirected")
                    }
                    Spacer()
                    VStack(alignment: .leading){
                        Toggle(isOn: $penaltyShot){
                            
                        }
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle(tint: Color.NPSButtonStart))
                        Text("Penalty Shot")
                    }
                    Spacer()
                    VStack(alignment: .leading){
                        Toggle(isOn: $overTimeGoal){
                        }
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle(tint: Color.NPSButtonStart))
                        Text("Overtime Shot")
                    }
                }
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
                Spacer() 
                HStack{
                    Button(action: {
                        //self.showSaveGoalView.toggle()
                        showGoalDetailsView.toggle()
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
                        //self.showSaveGoalView.toggle()
                        showGoalDetailsView.toggle()
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
        .border(Color.black)
        .clipShape(RoundedRectangle(cornerRadius: 16))       // << here !!
        .frame(width: UIScreen.main.bounds.width - 5, height: 500, alignment: .center)
    }
}

//struct GoalLocationView_Previews: PreviewProvider {
//    static var previews: some View {
//        GoalLocationView().colorScheme(.dark)
//    }
//}
