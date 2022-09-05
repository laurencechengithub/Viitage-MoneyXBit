//
//  Quote.swift
//  ViitageEX
//
//  Created by LaurenceMBP2 on 2022/7/4.
//

import Foundation

struct Quote : Codable, Identifiable {
    var id = UUID()
    var globalQuote: GlobalQuote
    
    enum CodingKeys: String, CodingKey {
        case globalQuote = "Global Quote"
    
    }
}

struct GlobalQuote : Codable {
    var the01Symbol, the02Open, the03High, the04Low: String
    var the05Price, the06Volume, the07LatestTradingDay, the08PreviousClose: String
    var the09Change, the10ChangePercent: String

    enum CodingKeys: String, CodingKey {
        case the01Symbol            = "01. symbol"
        case the02Open              = "02. open"
        case the03High              = "03. high"
        case the04Low               = "04. low"
        case the05Price             = "05. price"
        case the06Volume            = "06. volume"
        case the07LatestTradingDay  = "07. latest trading day"
        case the08PreviousClose     = "08. previous close"
        case the09Change            = "09. change"
        case the10ChangePercent     = "10. change percent"
    }
}

