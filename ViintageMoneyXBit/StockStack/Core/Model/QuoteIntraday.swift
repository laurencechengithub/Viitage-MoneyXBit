//
//  QuoteIntraday.swift
//  ViitageEX
//
//  Created by LaurenceMBP2 on 2022/7/4.
//

import Foundation

struct QuoteIntraday: Codable,Identifiable {
    var id = UUID()
    var metaData: MetaData
    var timeSeries60Min: [String: TimeSeries60Min]
    
    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeries60Min = "Time Series (60min)"
    }
}

struct MetaData : Codable {
    var the1Information, the2Symbol: String
    var the3LastRefreshed : String
    var the4Interval: String
    var the5OutputSize: String
    var the6TimeZone: String
    
    private enum CodingKeys : String, CodingKey {
        case the1Information    = "1. Information"
        case the2Symbol         = "2. Symbol"
        case the3LastRefreshed  = "3. Last Refreshed"
        case the4Interval       = "4. Interval"
        case the5OutputSize     = "5. Output Size"
        case the6TimeZone       = "6. Time Zone"
    }
}

struct TimeSeries60Min: Codable {
    var the1Open, the2High, the3Low, the4Close: String
    var the5Volume: String
    
    enum CodingKeys: String, CodingKey {
        case the1Open   = "1. open"
        case the2High   = "2. high"
        case the3Low    = "3. low"
        case the4Close  = "4. close"
        case the5Volume = "5. volume"
    }
}
