//
//  HapticManager.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/26.
//

import Foundation
import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type : UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
    
}
