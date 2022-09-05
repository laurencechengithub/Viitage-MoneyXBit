//
//  Ext+UIapplication.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/13.
//

import Foundation
import SwiftUI


extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
}
