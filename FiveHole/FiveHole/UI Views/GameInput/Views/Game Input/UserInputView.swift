//
//  UserInputView.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 11/25/20.
//

import SwiftUI

struct UserInputView: View {
    @State var showAddGoalieView = false
    @Binding var showGoalDetailsView: Bool
    @State var savesVar = 0.0
    @State var goalsVar = 0.0
    @State var savePercentVar = 100.0
    @State var totalShotsVar = 0.0
        
    var body: some View {
        ZStack {
            LinearGradient(Color.NPSBackgroundGradientStart)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing:10) {
                Button("Current Goalie"){
                    //TODO:
                    //Show simple list of goalies
                    //with checkbox/radio buttons
                }.frame(height: 40)
                HStack{
                    Text("Saves")
                        .foregroundColor(.NPSTextColor)
                    Spacer()
                    Text("Save %")
                        .foregroundColor(.NPSTextColor)
                    Spacer()
                    Text("Goals")
                        .foregroundColor(.NPSTextColor)
                }
                HStack{
                    ZStack{
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: 50, height: 50)
                        Text(String(format:"%.0f", savesVar))
                            .foregroundColor(.NPSTextColor)
                    }
                    Spacer()
                    ZStack{
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: 50, height: 50)
                        Text(String(format:"%.0f", savePercentVar))
                            .foregroundColor(.NPSTextColor)
                            + Text("%")
                            .foregroundColor(.NPSTextColor)
                    }
                    Spacer()
                    ZStack{
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: 50, height: 50)
                        Text(String(format:"%.0f", goalsVar))
                            .foregroundColor(.NPSTextColor)
                    }
                }
                HStack{
                    Button(action: {
                        savesVar += 1
                        calculateSavePercent()
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    }){
                        Text("Save")
                            .foregroundColor(.NPSTextColor)
                            .minimumScaleFactor(0.01)
                            .scaledToFill()
                            .lineLimit(1)
                    }.buttonStyle(ColorfulButtonStyle())
                    .offset(x:-12)
                    Spacer()
                    VStack{
                        ZStack {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(width: 50, height: 50)
                            Text(String(format: "%.0f", totalShotsVar))
                                .foregroundColor(.NPSTextColor)
                        }
                        Text("Total Shots")
                            .foregroundColor(.NPSTextColor)
                    }
                    Spacer()
                    Button(action: {
                        goalsVar += 1
                        calculateSavePercent()
                        self.showGoalDetailsView.toggle()
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    }){
                        Text("Goal")
                            .foregroundColor(.NPSTextColor)
                            .minimumScaleFactor(0.01)
                            .scaledToFill()
                            .lineLimit(1)
                        
                    }.buttonStyle(ColorfulButtonStyle())
                    .offset(x:12)
                }
                HStack{
                    ZStack{
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 50, height: 50)
                        Text("-")
                    }.gesture(
                        TapGesture()
                            .onEnded{
                                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                impactMed.impactOccurred()
                                if savesVar > 0 {
                                    savesVar -= 1
                                    calculateSavePercent()
                                }
                            })
                    Spacer()
                    ZStack{
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 50, height: 50)
                        Text("-")
                    }.gesture(
                        TapGesture()
                            .onEnded{
                                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                impactMed.impactOccurred()
                                if goalsVar > 0 {
                                    goalsVar -= 1
                                    calculateSavePercent()
                                }
                            })
                }
                Spacer()
            }
            .sheet(isPresented: $showAddGoalieView) {
                //AddGoalieView(showAddGoalieView: $showAddGoalieView)
            }
        }
    }
    
    private func calculateSavePercent(){
        savePercentVar = Double(savesVar/(savesVar + goalsVar))
        totalShotsVar = savesVar + goalsVar
        savePercentVar = savePercentVar * 100
        if savePercentVar.isNaN {
            savePercentVar = 100.0
        }
    }
}
