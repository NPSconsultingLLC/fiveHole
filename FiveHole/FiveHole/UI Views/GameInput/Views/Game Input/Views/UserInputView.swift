//
//  UserInputView.swift
//  FiveHole
//
//  Updated to track goal locations
//

import SwiftUI

struct UserInputView: View {
    @Binding var showGoalDetailsView: Bool
    @Binding var savesVar: Double
    @Binding var goalsVar: Double
    @Binding var goalLocations: [GoalLocation]
    
    @State var showGoaliePickerView = false
    @State var savePercentVar = 100.0
    @State var totalShotsVar = 0.0
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Goalies.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Goalies.fName, ascending: true)
        ]
    ) var fetchedGoalies: FetchedResults<Goalies>
    
    var body: some View {
        ZStack {
            LinearGradient(Color.NPSBackgroundGradientStart)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing:10) {
                Button(action: {
                    showGoaliePickerView.toggle()
                }){
                    let selectedGoalie = setSelectedGoalie()
                    Text(selectedGoalie)
                }
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
                        savePercentVar = gameCalculator.calculateSavePercent(savesVar: savesVar, goalsVar: goalsVar)
                        totalShotsVar = gameCalculator.calculateTotalShots(savesVar: savesVar, goalsVar: goalsVar)
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
                        savePercentVar = gameCalculator.calculateSavePercent(savesVar: savesVar, goalsVar: goalsVar)
                        totalShotsVar = gameCalculator.calculateTotalShots(savesVar: savesVar, goalsVar: goalsVar)
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
                                    savePercentVar = gameCalculator.calculateSavePercent(savesVar: savesVar, goalsVar: goalsVar)
                                    totalShotsVar = gameCalculator.calculateTotalShots(savesVar: savesVar, goalsVar: goalsVar)
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
                                    savePercentVar = gameCalculator.calculateSavePercent(savesVar: savesVar, goalsVar: goalsVar)
                                    totalShotsVar = gameCalculator.calculateTotalShots(savesVar: savesVar, goalsVar: goalsVar)
                                    
                                    // Remove last goal from visualization
                                    if !goalLocations.isEmpty {
                                        goalLocations.removeLast()
                                    }
                                }
                            })
                }
                Spacer()
            }
            .sheet(isPresented: $showGoaliePickerView) {
                GoaliePickerView(showGoaliePickerView: $showGoaliePickerView)
            }
        }
    }
    
    private func setSelectedGoalie() -> String{
        var selectedGoalie = "Choose Goalie"
        for goalie in fetchedGoalies {
            if goalie.selectedGoalie {
                selectedGoalie = goalie.fName! + " " + goalie.lName!
            }
        }
        return selectedGoalie
    }
}

struct UserInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserInputView(
            showGoalDetailsView: .constant(false),
            savesVar: .constant(10),
            goalsVar: .constant(3),
            goalLocations: .constant([.topLeft, .bottomMiddle, .middleRight])
        )
    }
}
