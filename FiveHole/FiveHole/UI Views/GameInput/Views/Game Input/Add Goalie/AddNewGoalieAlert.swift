//
//  AddNewGoalieAlert.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 12/16/20.
//

import SwiftUI

struct AddNewGoalieAlert: View {
    @Binding var showingAddNewGoalie: Bool
    @State private var fName = ""
    @State private var lName = ""
    @State private var teamName = ""
    
    var body: some View {
        ZStack {
            VStack {
                RoundedRectangle(cornerRadius: 8.0, style: .continuous)
                    .fill(LinearGradient(.NPSDarkStart, .NPSDarkEnd))
                HStack{
                    Button(action: {
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                        self.showingAddNewGoalie.toggle()
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
                        self.showingAddNewGoalie.toggle()
                    }){
                        Text("Cancel")
                            .foregroundColor(.NPSTextColor)
                            .minimumScaleFactor(0.01)
                            .scaledToFill()
                            .lineLimit(1)
                    }.buttonStyle(ColorfulButtonStyle())
                }
                
            }.padding()
            HStack {
                VStack{
                    Spacer()
                        .frame(height: 5)
                    TextField("First Name", text: $fName)
                        .frame(height: 44)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.leading, .trailing], 10)
                        .cornerRadius(16)
                        .background(Color.NPSShadowColor)
                        .clipShape(RoundedRectangle(cornerRadius: 10)) // clip corners
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                        .padding([.leading, .trailing], 5)
                    
                    TextField("Last Name", text: $lName)
                        .frame(height: 44)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.leading, .trailing], 10)
                        .cornerRadius(16)
                        .background(Color.NPSShadowColor)
                        .clipShape(RoundedRectangle(cornerRadius: 10)) // clip corners
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                        .padding([.leading, .trailing], 5)
                    TextField("Team Name", text: $teamName)
                        .frame(height: 44)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding([.leading, .trailing], 10)
                        .cornerRadius(16)
                        .background(Color.NPSShadowColor)
                        .clipShape(RoundedRectangle(cornerRadius: 10)) // clip corners
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                        .padding([.leading, .trailing], 5)
                    Spacer()
                        .frame(height: 95)
                }.padding()
                VStack {
                    Spacer()
                        .frame(height: 5)
                    ZStack{
                        RoundedRectangle(cornerRadius: 8.0, style: .continuous)
                            .fill(LinearGradient(.NPSBackgroundGradientEnd, .NPSButtonEnd))
                            .frame(width: 150, height: 160)
                            .padding()
                        Image(systemName: "camera")
                    }
                    Spacer()
                }
                Spacer()
            }
            
        }.frame(width: UIScreen.main.bounds.width, height: 290)
        
    }
}

struct AddNewGoalieAlert_Previews: PreviewProvider {
    static var previews: some View {
        AddNewGoalieAlert(showingAddNewGoalie: .constant(true))
    }
}
