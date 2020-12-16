//
//  AddNewGoalieAlert.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 12/16/20.
//

import SwiftUI

struct AddNewGoalieAlert: View {
    @State var showingAddNewGoalie = false
    @State private var fName = ""
    @State private var lName = ""
    @State private var teamName = ""
    
    var body: some View {
        ZStack {
            VStack {
                RoundedRectangle(cornerRadius: 8.0, style: .continuous)
                    .fill(LinearGradient(.NPSButtonStart, .NPSButtonEnd))
                    .shadow(color: .NPSDarkStart, radius: 5, x: 3, y: 3)
                    .shadow(color: .NPSDarkEnd, radius: 5, x: -3, y: -3)
                HStack{
                    Button(action: {
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    }){
                        Text("Save")
                            .foregroundColor(.NPSTextColor)
                            .minimumScaleFactor(0.01)
                            .scaledToFill()
                            .lineLimit(1)
                    }.buttonStyle(ColorfulButtonStyle())
                    Spacer()
                    Button(action: {
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    }){
                        Text("Cancel")
                            .foregroundColor(.NPSTextColor)
                            .minimumScaleFactor(0.01)
                            .scaledToFill()
                            .lineLimit(1)
                    }.buttonStyle(ColorfulButtonStyle())
                }
                
            }.padding()
            VStack{
                Spacer()
                        .frame(height: 5)
                TextField("First Name", text: $fName)
                    .frame(height: 44)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding([.leading, .trailing], 10)
                    .cornerRadius(16)
                    .background(Color.NPSDarkStart)
                    .clipShape(RoundedRectangle(cornerRadius: 10)) // clip corners
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                    .padding([.leading, .trailing], 24)
                    .foregroundColor(.NPSTextColor)
                    
                TextField("Last Name", text: $lName)
                    .frame(height: 44)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding([.leading, .trailing], 10)
                    .cornerRadius(16)
                    .background(Color.NPSDarkStart)
                    .clipShape(RoundedRectangle(cornerRadius: 10)) // clip corners
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                    .padding([.leading, .trailing], 24)
                    .foregroundColor(.NPSTextColor)
                TextField("Team Name", text: $teamName)
                    .frame(height: 44)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding([.leading, .trailing], 10)
                    .cornerRadius(16)
                    .background(Color.NPSDarkStart)
                    .clipShape(RoundedRectangle(cornerRadius: 10)) // clip corners
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                    .padding([.leading, .trailing], 24)
                    .foregroundColor(.NPSTextColor)
                Spacer()
                    .frame(height: 95)
            }.padding()
        
        }.frame(width: UIScreen.main.bounds.width, height: 290)
        
    }
}

struct AddNewGoalieAlert_Previews: PreviewProvider {
    static var previews: some View {
        AddNewGoalieAlert(showingAddNewGoalie: true)
    }
}
