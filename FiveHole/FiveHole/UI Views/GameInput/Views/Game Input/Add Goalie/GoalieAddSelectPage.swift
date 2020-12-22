//
//  GoalieAddSelectPage.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 12/16/20.
//

import SwiftUI

struct GoalieAddSelectPage: View {
    @State var showingAddNewGoalie = false

    var body: some View {
        ScrollView{
            GoalieProfileView(showingAddNewGoalie: showingAddNewGoalie)
        }
    }
}

struct GoalieProfileView: View {
    @State var showingAddNewGoalie = false
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: Goalies.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Goalies.fName, ascending: true)
        ]
    ) var goalies: FetchedResults<Goalies>

    var body: some View {
        ZStack{
            VStack{
                TabView{
                    if goalies.count > 0 {
                        ForEach(goalies) { goalie in
                            VStack{
                                ZStack{
                                    RoundedRectangle(cornerRadius: 8.0, style: .continuous)
                                        .fill(LinearGradient(.NPSButtonStart, .NPSButtonEnd))
                                        .shadow(color: .NPSDarkStart, radius: 5, x: 3, y: 3)
                                        .shadow(color: .NPSDarkEnd, radius: 5, x: -3, y: -3)
                                    VStack {
                                        Spacer()
                                        Button(action: {
                                            removeGoalie(goalieToDelete: goalie)
                                        }) {
                                            Text("Delete")
                                                .frame(minWidth: 0, maxWidth: .infinity)
                                                .font(.system(size: 18))
                                                .padding()
                                                .foregroundColor(.NPSDarkEnd)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 25)
                                                        .stroke(Color.NPSDarkEnd, lineWidth: 2)
                                                )
                                        }
                                    }.padding()
                                }.padding()
                                HStack(alignment: .top){
                                    VStack(alignment: .leading){
                                        HStack {
                                            Text(goalie.fName ?? "First Name")
                                                .font(.title)
                                                .foregroundColor(.NPSTextColor)
                                            Text(goalie.lName ?? "Last Name")
                                                .font(.title)
                                                .foregroundColor(.NPSTextColor)
                                            Spacer()
                                        }
                                        
                                        Text(goalie.tName ?? "Team Name")
                                            .font(.subheadline)
                                            .foregroundColor(.NPSTextColor)
                                    }.padding()
                                    Spacer()
                                }
                            }
                        }
                    } else {
                        VStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 8.0, style: .continuous)
                                    .fill(LinearGradient(.NPSButtonStart, .NPSButtonEnd))
                                    .shadow(color: .NPSDarkStart, radius: 5, x: 3, y: 3)
                                    .shadow(color: .NPSDarkEnd, radius: 5, x: -3, y: -3)
                                    .onTapGesture(count: 1, perform: {
                                        self.showingAddNewGoalie.toggle()
                                    })
                                Text("Add New Goalie")
                                    .font(.largeTitle)
                                    .foregroundColor(.NPSTextColor)
                            }.padding()
                            HStack(alignment: .top){
                                VStack(alignment: .leading){
                                    HStack {
                                        Text("First Name")
                                            .font(.title)
                                            .foregroundColor(.NPSTextColor)
                                        Text("Last Name")
                                            .font(.title)
                                            .foregroundColor(.NPSTextColor)
                                        Spacer()
                                    }
                                    
                                    Text("Team Name")
                                        .font(.subheadline)
                                        .foregroundColor(.NPSTextColor)
                                }.padding()
                                Spacer()
                            }
                        }
                    }
                }.frame(width: UIScreen.main.bounds.width, height: 400)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                Spacer()
                TabView{
                    ForEach(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { _ in
                        VStack{
                            RoundedRectangle(cornerRadius: 8.0, style: .continuous)
                                .fill(LinearGradient(.NPSButtonStart, .NPSButtonEnd))
                                .shadow(color: .NPSDarkEnd, radius: 5, x: -3, y: -3)
                                .shadow(color: .NPSDarkStart, radius: 5, x: 3, y: 3)
                            Spacer()
                        }
                    }
                    .padding()
                }.frame(width: UIScreen.main.bounds.width, height: 200)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }.blur(radius: showingAddNewGoalie ? 30 : 0)
            
            if showingAddNewGoalie {
                AddNewGoalieAlert(showingAddNewGoalie: $showingAddNewGoalie)
            } else {
                AddNewGoalieAlert(showingAddNewGoalie: $showingAddNewGoalie).hidden()
            }
        }
    }
    private func removeGoalie(goalieToDelete: Goalies) {
        managedObjectContext.delete(goalieToDelete)
        saveContext()
    }
    
    private func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
}

struct GoalieProfileView_preview: PreviewProvider {
    static var previews: some View {
        GoalieProfileView()
    }
}
