//
//  Color.swift
//  ViitageEX
//
//  Created by LaurenceMBP2 on 2022/6/30.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
    static let launchTheme = LaunchTheme()
    
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let bg = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}


struct LaunchTheme {
    let bg = Color("LaunchBackGround")
    let accent = Color("LaunchAccent")
}

