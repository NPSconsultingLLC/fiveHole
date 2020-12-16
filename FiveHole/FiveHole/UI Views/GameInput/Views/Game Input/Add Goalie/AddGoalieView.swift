//
//  AddGoalieView.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 12/6/20.
//

import SwiftUI

struct AddGoalieView: View {
    @State private var selectedFrameworkIndex = 0
    @Environment(\.managedObjectContext) var managedObjectContext
    @Binding var showAddGoalieView: Bool
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var teamName: String = ""
    
    @FetchRequest(
        entity: Goalies.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Goalies.fName, ascending: true)
        ]
    ) var goalies: FetchedResults<Goalies>
    //TODO - Cancle Button
    //TODO - Populate Name info with selected goalie
    
    var body: some View {
        NavigationView{
            Form{
                Section {
                    Picker(selection: $selectedFrameworkIndex, label: Text("Selected Goalie")) {
                        ForEach(goalies, id: \.fName) { goalie in
                            Text(goalie.fName ?? "Unknown")
                        }
                    }
                }
                TextField("First Name", text: $firstName)
                TextField("LastName", text: $lastName)
                TextField("Team", text: $teamName)
                Button("Save"){
                    addGoalie()
                    self.showAddGoalieView.toggle()
                }
            }
        }
    }
    
    private func addGoalie() {
        let newGoalie = Goalies(context: managedObjectContext)
        newGoalie.fName = firstName
        newGoalie.lName = lastName
        newGoalie.tName = teamName
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

//struct AddGoalieView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddGoalieView(showAddGoalieView: .constant(true))
//    }
//}
