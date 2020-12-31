//
//  GameReviewView.swift
//  FiveHole
//
//  Created by Nathan Stryker on 12/24/20.
//

import SwiftUI

struct GameReviewView: View {
    @Binding var showingSaveGameView: Bool
    
    @State private var opponentName = ""
    @State var saveUserScore = ""
    @State var saveOpponentScore = ""
    
    var userScore: String
    var opponentScore: String

    var body: some View {
        VStack{
            Text("Game Review")
                .font(.largeTitle)
                .foregroundColor(.NPSTextColor)
            Spacer()
                .frame(height: 50)
            HStack{
                Button(action: {
                    //Show Goalie Picker
                }) {
                    Text("Goalie Team Name")
                        .foregroundColor(.NPSButtonEnd)
                }
                Spacer()
                Text("Opponent Team")
                    .foregroundColor(.NPSTextColor)
            }
            HStack {
                TextField(userScore, text: $saveUserScore)
                    .frame(width: 100, height: 100)
                    .background(RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.NPSButtonStart)
                                    .frame(width: 100, height: 100))
                Spacer()
                TextField(opponentScore, text: $saveOpponentScore)
                    .frame(width: 100, height: 100)
                    .background(RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.NPSButtonStart)
                                    .frame(width: 100, height: 100))
            }.font(Font.system(size: 60, design: .default))
            .multilineTextAlignment(.center)
            Text("Opponent Name")
            TextField("Opponent", text: $opponentName)
                .frame(height: 44)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 4)) // clip corners
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.gray))
                .foregroundColor(.white)
            TextField("Ice time", text: $opponentName)
                .frame(height: 44)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 4)) // clip corners
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.gray))
                .foregroundColor(.white)
            Spacer()
            Button(action: {
                //Cancel
                showingSaveGameView.toggle()
            }) {
                Text("Cancel")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.system(size: 18))
                    .padding()
                    .foregroundColor(.NPSButtonEnd)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.NPSButtonEnd, lineWidth: 2)
                    )
            }
            Button(action: {
                //Save Game Action
                showingSaveGameView.toggle()
            }) {
                Text("Save Game")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.system(size: 18))
                    .padding()
                    .foregroundColor(.NPSButtonEnd)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.NPSButtonEnd, lineWidth: 2)
                    )
            }
        }.padding()
    }
}

struct GameReviewView_Previews: PreviewProvider {

    static var previews: some View {
        GameReviewView(showingSaveGameView: .constant(true), userScore: "5", opponentScore: "3")
    }
}
