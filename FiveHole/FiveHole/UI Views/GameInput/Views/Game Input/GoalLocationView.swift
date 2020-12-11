//
//  GoalLocationView.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 11/25/20.
//

import SwiftUI

enum GoalLocation {
    case topLeft
    case topRight
    case middleLeft
    case middleRight
    case bottomLeft
    case bottomMiddle
    case bottmRight
}

struct GoalLocationView: View {
    @State private var isToggled = false
    //Track the selected goal location
    //@Binding var selectedItem: SmartView
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Toggle(isOn: $isToggled) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.white)
                    }
                    .toggleStyle(ColorfulToggleStyle())
                    
                    Text("Button Label")
                        .foregroundColor(Color("NPSTextColor"))
                }
                Spacer()
                VStack {
                    Toggle(isOn: $isToggled) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.white)
                    }
                    .toggleStyle(ColorfulToggleStyle())
                    Text("Button Label")
                        .foregroundColor(Color("NPSTextColor"))
                }
            }
            Spacer()
            HStack {
                VStack {
                    Toggle(isOn: $isToggled) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.white)
                    }
                    .toggleStyle(ColorfulToggleStyle())
                    Text("Button Label")
                        .foregroundColor(Color("NPSTextColor"))
                }
                Spacer()
                VStack {
                    Toggle(isOn: $isToggled) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.white)
                    }
                    .toggleStyle(ColorfulToggleStyle())
                    Text("Button Label")
                        .foregroundColor(Color("NPSTextColor"))
                }
            }
            Spacer()
            HStack {
                VStack {
                    Toggle(isOn: $isToggled) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.white)
                    }
                    .toggleStyle(ColorfulToggleStyle())
                    Text("Button Label")
                        .foregroundColor(Color("NPSTextColor"))
                }
                Spacer()
                VStack {
                    Toggle(isOn: $isToggled) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.white)
                    }
                    .toggleStyle(ColorfulToggleStyle())
                    Text("Button Label")
                        .foregroundColor(Color("NPSTextColor"))
                }
                Spacer()
                VStack {
                    Toggle(isOn: $isToggled) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.white)
                    }
                    .toggleStyle(ColorfulToggleStyle())
                    Text("Button Label")
                        .foregroundColor(Color("NPSTextColor"))
                }
            }
        }.padding()
    }
}

struct GoalLocationView_Previews: PreviewProvider {
    static var previews: some View {
        GoalLocationView().colorScheme(.dark)
    }
}
