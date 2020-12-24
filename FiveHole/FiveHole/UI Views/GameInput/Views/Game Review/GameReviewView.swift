//
//  GameReviewView.swift
//  FiveHole
//
//  Created by Nathan Stryker on 12/24/20.
//

import SwiftUI

struct GameReviewView: View {
    @State private var opponentName = ""
    @State var homeScore = ""
    @State var awayScore = ""
    
    var body: some View {
        VStack{
            HStack{
                Text("Home Team")
                Spacer()
                Text("Away Team")
            }
            HStack {
                TextField("6", text: $homeScore)
                    .frame(width: 100, height: 100)
                    .multilineTextAlignment(.center)
                    .background(RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.NPSButtonStart)
                                    .frame(width: 100, height: 100))
                Spacer()
                TextField("23", text: $homeScore)
                    .frame(width: 100, height: 100)
                    .multilineTextAlignment(.center)
                    .background(RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.NPSButtonStart)
                                    .frame(width: 100, height: 100))
            }
            
            
            TextField("Opponent", text: $opponentName)
                .frame(height: 44)
                .textFieldStyle(PlainTextFieldStyle())
                .padding([.leading, .trailing], 10)
                .cornerRadius(16)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 4)) // clip corners
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.gray))
                .foregroundColor(.white)
                .padding([.leading, .trailing], 5)
            Spacer()
        }.padding()
    }
}

struct GameReviewView_Previews: PreviewProvider {
    static var previews: some View {
        GameReviewView()
    }
}
