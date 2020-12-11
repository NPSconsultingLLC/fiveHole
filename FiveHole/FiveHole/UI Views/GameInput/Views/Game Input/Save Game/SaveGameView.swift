//
//  SaveGameView.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 12/6/20.
//

import SwiftUI
import CoreData

struct SaveGameView: View {
    @Binding var showSaveGameView: Bool
    @Environment(\.managedObjectContext) var managedObjectContext
    var passedGoalsAgainst: Int16?
    var passedTotalShots: Int16?
    
    //things that need to be entered
    //GameDate
    //Goals For
    //Is win (bool that users can change)
    //Opponent
    //calculate total saves (total shots - goals against)
    //set Season
    //TODO: Make buttons change color on toggle (so that you can tell which goal location was tapped
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(
                    gradient: .init(colors: [Color.NPSBackgroundGradientStart, Color.NPSBackgroundGradientEnd]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .clipped()
            
            VStack {
                GoalModifierView()
                Spacer()
                GoalLocationView()
                Spacer()
            }
        }
        .border(Color.black)
        .clipShape(RoundedRectangle(cornerRadius: 16))       // << here !!
        .frame(width: UIScreen.main.bounds.width - 5, height: 500, alignment: .center)   
    }
    
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
}

//MARK: Previewer
struct SaveGameView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            Group {
                SaveGameView(showSaveGameView: .constant(true), passedGoalsAgainst: 3, passedTotalShots: 32).colorScheme(.dark)
            }
        }
    }
}
