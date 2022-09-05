//
//  Statistic.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/15.
//

import Foundation

struct Statistic:Identifiable {
    
    let id = UUID()
    let title:String
    let value:String
    let percentageChange:Double?
    
    init(title:String,value:String,percentageChange:Double? = nil ) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
