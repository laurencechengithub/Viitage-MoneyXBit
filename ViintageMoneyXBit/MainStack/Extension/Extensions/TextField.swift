//
//  TextField.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/8/8.
//

import SwiftUI

extension TextField {
    
    func resignFirstResponder() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

