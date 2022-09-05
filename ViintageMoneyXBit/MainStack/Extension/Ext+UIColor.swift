//
//  Ext+UIColor.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/6.
//

import Foundation
import UIKit

extension UIColor {
    
    static let uiTheme = UIColorTheme()
    static let launchTheme = UILaunchTheme()
}

struct UIColorTheme {
    
    let accent = UIColor(named:"AccentColor")
    let bg = UIColor(named:"BackgroundColor")
    let green = UIColor(named:"GreenColor")
    let red = UIColor(named:"RedColor")
    let secondaryText = UIColor(named:"SecondaryTextColor")
}

struct UILaunchTheme {
    let bg = UIColor(named:"LaunchBackGround")
    let accent = UIColor(named:"LaunchAccent")
}
