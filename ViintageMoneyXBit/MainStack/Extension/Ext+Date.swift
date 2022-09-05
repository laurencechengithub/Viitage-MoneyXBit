//
//  Ext+Date.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/8/1.
//

import Foundation

//"2021-03-13T20:49:26.606Z"


extension Date {
    
    init(viintageEXString:String) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = formatter.date(from: viintageEXString) ?? Date()
        self.init(timeInterval: 0, since: date)
        
    }
    
    
    
    func toYYYYMMDDFormatString() -> String {
        
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        return dateFormate.string(from: self)
    }
    
    func toShortFormatDateString() -> String {
        let shortFormatter = DateFormatter()
        shortFormatter.dateStyle = .short
        return shortFormatter.string(from: self)
    }
    
}
