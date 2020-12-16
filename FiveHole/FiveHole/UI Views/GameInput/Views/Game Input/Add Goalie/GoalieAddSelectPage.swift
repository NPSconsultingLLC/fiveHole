//
//  GoalieAddSelectPage.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 12/16/20.
//

import SwiftUI

struct GoalieAddSelectPage: View {
    var body: some View {
        ScrollView{
            GoalieProfileView()
        }
    }
}

struct GoalieProfileView: View {
    var body: some View {
        VStack{
            TabView{
                ForEach(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { _ in
                    VStack{
                        RoundedRectangle(cornerRadius: 8.0, style: .continuous)
                            .fill(LinearGradient(.NPSButtonStart, .NPSButtonEnd))
                            .shadow(color: .NPSDarkStart, radius: 5, x: 3, y: 3)
                            .shadow(color: .NPSDarkEnd, radius: 5, x: -3, y: -3)
                        Spacer()
                    }
                }
                .padding()
            }.frame(width: UIScreen.main.bounds.width, height: 400)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            HStack(alignment: .top){
                VStack(alignment: .leading){
                    Text("First / Last Name")
                        .font(.title)
                        .foregroundColor(.NPSTextColor)
                    Text("team Name")
                        .font(.subheadline)
                        .foregroundColor(.NPSTextColor)
                }.padding()
                Spacer()
            }
            Spacer()
            TabView{
                ForEach(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { _ in
                    VStack{
                        RoundedRectangle(cornerRadius: 8.0, style: .continuous)
                            .fill(LinearGradient(.NPSButtonStart, .NPSButtonEnd))
                            .shadow(color: .NPSDarkEnd, radius: 5, x: -3, y: -3)
                            .shadow(color: .NPSDarkStart, radius: 5, x: 3, y: 3)
                            
                        Spacer()
                    }
                }
                .padding()
            }.frame(width: UIScreen.main.bounds.width, height: 200)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct GoalieAddSelectPage_Previews: PreviewProvider {
    static var previews: some View {
        GoalieAddSelectPage().colorScheme(.light)
    }
}
