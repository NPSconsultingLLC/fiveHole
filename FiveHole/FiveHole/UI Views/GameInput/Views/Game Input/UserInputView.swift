//
//  UserInputView.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 11/25/20.
//

import SwiftUI

struct UserInputView: View {
    @State var showAddGoalieView = false
    @State var savesVar = 0.0
    @State var goalsVar = 0.0
    @State var savePercentVar = 100.0
    @State var totalShotsVar = 0.0
    @FetchRequest(
        entity: Goalie.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Goalie.fName, ascending: true)
        ]
    ) var goalies: FetchedResults<Goalie>
    
    var body: some View {
        VStack {
            Button("Add Goalie"){
                self.showAddGoalieView.toggle()
            }.frame(height: 40)
            HStack{
                Text("Saves")
                Spacer()
                Text("Save %")
                Spacer()
                Text("Goals")
            }
            HStack{
                ZStack{
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 50, height: 50)
                    Text(String(format:"%.0f", savesVar))
                }
                Spacer()
                ZStack{
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 50, height: 50)
                    Text(String(format:"%.0f", savePercentVar))
                        + Text("%")
                }
                Spacer()
                ZStack{
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 50, height: 50)
                    Text(String(format:"%.0f", goalsVar))
                }
            }
            HStack{
                Button(action: {
                    savesVar += 1
                    calculateSavePercent()
                }){
                    Text("Save")
                }.buttonStyle(BlueButtonStyle())
                .offset(x:-12)
                Spacer()
                VStack{
                    ZStack {
                        Rectangle()
                            .fill(Color.red)
                            .frame(width: 50, height: 50)
                        Text(String(format: "%.0f", totalShotsVar))
                    }
                    Text("Total Shots")
                }
                Spacer()
                Button(action: {
                    goalsVar += 1
                    calculateSavePercent()
                }){
                    Text("Goal")
                }.buttonStyle(BlueButtonStyle())
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
                            if goalsVar > 0 {
                                goalsVar -= 1
                                calculateSavePercent()
                            }
                        })
            }
        }
        .sheet(isPresented: $showAddGoalieView) {
            AddGoalieView(showAddGoalieView: $showAddGoalieView)
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

struct UserInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserInputView()
    }
}
