//
//  GoalieAddSelectPage.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 12/16/20.
//

import SwiftUI

//TODO: Need to figure out how to update the goalies list and not sure how to do that properly
//Right now if you delete a goalie it doesnt delete the card but it does
//delete the goalie from the CoreData Stack

struct GoalieAddSelectPage: View {
    
    @State var showingAddNewGoalie = false
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Goalies.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Goalies.fName, ascending: true)
        ]
    ) var fetchedGoalies: FetchedResults<Goalies>
    
    var body: some View {
        TabView{
            if(fetchedGoalies.count > 0){
                ForEach(fetchedGoalies) { goalie in
                    GoalieProfileView(showingAddNewGoalie: showingAddNewGoalie, goalie: goalie, managedObjectContext: _managedObjectContext)
                }
                AddGoalieView(showingAddNewGoalie: false)
            } else{
                AddGoalieView(showingAddNewGoalie: false)
            }
            
        }.frame(width: UIScreen.main.bounds.width, height: 400)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

struct GoalieProfileView: View {
    @State var showingAddNewGoalie = false
    @ObservedObject var goalie: Goalies
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        ZStack{
            VStack{
                TabView{
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
                Spacer()
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

struct AddGoalieView: View{
    @State var showingAddNewGoalie = false
    @Environment(\.managedObjectContext) var managedObjectContext
    var body: some View {
        ZStack{
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
            }.padding()
            
            
            if showingAddNewGoalie {
                AddNewGoalieAlert(showingAddNewGoalie: $showingAddNewGoalie)
            } else {
                AddNewGoalieAlert(showingAddNewGoalie: $showingAddNewGoalie).hidden()
            }
        }
    }
    
    private func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
}
