//
//  MarketData.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/15.
//

import Foundation

struct MarketData: Codable {
    var data: Market
}

struct Market: Codable {
    var activeCryptocurrencies, upcomingIcos, ongoingIcos, endedIcos: Int
    var markets: Int
    var totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    var marketCapChangePercentage24HUsd: Double
    var updatedAt: Int

    enum CodingKeys: String, CodingKey {
        case activeCryptocurrencies = "active_cryptocurrencies"
        case upcomingIcos = "upcoming_icos"
        case ongoingIcos = "ongoing_icos"
        case endedIcos = "ended_icos"
        case markets
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
        case updatedAt = "updated_at"
    }
    
    var USDMarketCap : String {
        
        if let cap = self.totalMarketCap.first(where: { $0.key == "usd" }) {
            return "$" + "\(cap.value.formattedWithAbbreviations())"
        }
//        //換個寫法
//        if let cap = self.totalMarketCap.first(where: { (key: String, value: Double) in
//            return key == "usd"
//        }) {
//            return "\(cap.value)"
//        }
        return "none"
    }
    
    var USDVolume : String {
        if let vol = self.totalVolume.first(where: { return $0.key == "usd"} ) {
            return "$" + "\(vol.value.formattedWithAbbreviations())"
        }
        return "none"
    }
    
    var btcDominancePercentage: String {
        if let btcD = self.marketCapPercentage.first(where: { return $0.key == "btc"} ) {
            return btcD.value.asPercentStringAndRoundTo2()
        }
        return "none"
        
    }
    
    
    
}
