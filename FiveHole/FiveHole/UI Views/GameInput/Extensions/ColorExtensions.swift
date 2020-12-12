//
//  ColorExtensions.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 12/11/20.
//

import SwiftUI
import UIKit 

extension Color {
    static let NPSBackgroundGradientStart           = Color("NPSDarkBackgroundColor")
    static let NPSBackgroundGradientEnd             = Color("NPSLightBackgroundColor")
    static let NPSTextColor                         = Color("NPSTextColor")
    static let NPSButtonStart                       = Color("NPSButtonStart")
    static let NPSButtonEnd                         = Color("NPSButtonEnd")
    static let NPSAlternateButtonColorStart         = Color("NPSAlternatButtonStart")
    static let NPSAlternateButtonColorEnd           = Color("NPSAlternatButtonEnd")
    static let NPSShadowColor                       = Color("NPSShadowColor")
    static let offWhite                             = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
    static let darkStart                            = Color("NPSDarkStart")
    static let darkEnd                              = Color("NPSDarkEnd")
    static let lightStart                           = Color("NPSLightStart")
    static let lightEnd                             = Color("NPSLightEnd")
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
}
