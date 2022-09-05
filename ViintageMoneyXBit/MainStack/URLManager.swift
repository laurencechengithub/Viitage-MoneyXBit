//
//  URLManager.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/26.
//

import Foundation

enum URLManager {
    static let stockApiKey = ENV.SERVICE_API_KEY
    static let getCoins = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h"
    static let getMarket = "https://api.coingecko.com/api/v3/global"
    static let getCoinDetailPrefix = "https://api.coingecko.com/api/v3/coins/"
    static let getCoinDetailHeaders = "localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
    static let alphavantageQuery = "https://www.alphavantage.co/query?"
}







protocol APIKEYS {
    var SERVICE_API_KEY: String {get}
}


class BaseENV {
    
    let dict: NSDictionary
    
    init(resourceName:String) {
        guard let filePath = Bundle.main.path(forResource: resourceName, ofType: "plist"),
        let plist = NSDictionary(contentsOfFile: filePath) else {
            fatalError("File not found : \(resourceName) plist")
        }
        self.dict = plist
    }
    
}


class DebugENV: BaseENV, APIKEYS {
    
    init() {
        super.init(resourceName: "DEBUG-Keys")
    }
    
    var SERVICE_API_KEY: String {
        dict.object(forKey: "COIN_API_KEY") as? String ?? ""
    }
    
}



class ProdENV: BaseENV, APIKEYS {
    
    init () {
        super.init(resourceName: "PROD-Keys")
    }
    
    var SERVICE_API_KEY: String {
        dict.object(forKey: "COIN_API_KEY") as? String ?? ""
    }
    
    
}

