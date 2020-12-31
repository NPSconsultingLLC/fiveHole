//
//  GoaliePickerView.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 12/30/20.
//

import SwiftUI

struct GoaliePickerView: View {
    @Binding var showGoaliePickerView: Bool
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Goalies.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Goalies.fName, ascending: true)
        ]
    ) var fetchedGoalies: FetchedResults<Goalies>
    
    var body: some View {
        
        if(fetchedGoalies.count > 0){
            List(fetchedGoalies) { goalie in
                Button(action: {
                    changeSelectedGoalie(selectedGoalie: goalie)
                    showGoaliePickerView.toggle()
                }) {
                    HStack{
                        VStack{
                            HStack{
                                Text(goalie.fName ?? "")
                                    .font(.title2)
                                Text(goalie.lName ?? "")
                                    .font(.title2)
                                Spacer()
                            }
                            HStack{
                                Text(goalie.tName ?? "")
                                    .font(.subheadline)
                                Spacer()
                            }
                        }
                        Spacer()
                        HStack{
                            Spacer()
                            if goalie.selectedGoalie {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.NPSButtonEnd)
                            }else {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.NPSButtonEnd).hidden()
                            }
                            
                        }
                    }
                }
            }
        } else {
            Button(action: {
                //pop to add goalie page
                
                showGoaliePickerView.toggle()
            }) {
                Text("Click here to add your first goalie")
            }
        }
    }
    
    private func changeSelectedGoalie(selectedGoalie: Goalies){
        for goalie in fetchedGoalies{
            if goalie == selectedGoalie {
                goalie.selectedGoalie = true
            } else {
                goalie.selectedGoalie = false 
            }
        }
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

struct GoaliePickerView_Previews: PreviewProvider {
    static var previews: some View {
        GoaliePickerView(showGoaliePickerView: .constant(true))
    }
}
