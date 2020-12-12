//
//  GoalModifierView.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 11/25/20.
//

import SwiftUI

struct GoalModifierView: View {
    
    @State private var redirected   = false
    @State private var penaltyShot  = false
    @State private var overTimeGoal = false
    
    var body: some View {
        ZStack {
            LinearGradient(Color.NPSBackgroundGradientStart)
                .edgesIgnoringSafeArea(.all)
            HStack{
                VStack{
                    Toggle(isOn: $redirected){
                    }
                    .labelsHidden()
                    Text("Redirected")
                }
                Spacer()
                VStack(alignment: .leading){
                    Toggle(isOn: $penaltyShot){
                        
                    }
                    .labelsHidden()
                    Text("Penalty Shot")
                }
                Spacer()
                VStack(alignment: .leading){
                    Toggle(isOn: $overTimeGoal){
                    }
                    .labelsHidden()
                    Text("Overtime Shot")
                }
            }
        }
    }
}

struct GoalModifierView_Previews: PreviewProvider {
    static var previews: some View {
        GoalModifierView()
    }
}
