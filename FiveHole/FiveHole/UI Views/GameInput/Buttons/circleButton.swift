//
//  circleButton.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 12/11/20.
//

import SwiftUI

struct circleButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 75, height: 75)
            //.foregroundColor(Color.NPSTextColor)
            .background(Color.NPSButtonStart)
            .clipShape(Circle())
    }
}
