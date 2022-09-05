//
//  SearchEquity.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/8/9.
//

import Foundation

struct SearchEquity:Decodable {

    let bestMatches: [Equity]
}

struct Equity:Decodable, Identifiable {
    var id = UUID()
    let the1Symbol, the2Name, the3Type, the4Region: String
    let the5MarketOpen, the6MarketClose, the7Timezone, the8Currency: String
    let the9MatchScore: String
    
    enum CodingKeys: String, CodingKey {
        case the1Symbol     = "1. symbol"
        case the2Name       = "2. name"
        case the3Type       = "3. type"
        case the4Region     = "4. region"
        case the5MarketOpen = "5. marketOpen"
        case the6MarketClose = "6. marketClose"
        case the7Timezone   = "7. timezone"
        case the8Currency   = "8. currency"
        case the9MatchScore = "9. matchScore"
    }
    
}


//
//{
//    "bestMatches": [
//        {
//            "1. symbol": "AA",
//            "2. name": "Alcoa Corp",
//            "3. type": "Equity",
//            "4. region": "United States",
//            "5. marketOpen": "09:30",
//            "6. marketClose": "16:00",
//            "7. timezone": "UTC-04",
//            "8. currency": "USD",
//            "9. matchScore": "1.0000"
//        },
//        {
//            "1. symbol": "AAA",
//            "2. name": "AXS FIRST PRIORITY CLO BOND ETF ",
//            "3. type": "ETF",
//            "4. region": "United States",
//            "5. marketOpen": "09:30",
//            "6. marketClose": "16:00",
//            "7. timezone": "UTC-04",
//            "8. currency": "USD",
//            "9. matchScore": "0.8000"
//        }
//    ]
//}
    
