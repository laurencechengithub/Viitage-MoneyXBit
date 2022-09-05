//
//  CoinDetailViewModel.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/27.
//

import Foundation
import Combine

class CoinDetailViewModel:ObservableObject {
    
    private var coinDetailDataService:CoinDetialDataService? = nil
    @Published var coin:Coin
    private var cancellables = Set<AnyCancellable>()
    
    @Published var downloadedCoinDetail:CoinDetail? = nil
    @Published var overviewStatics:[Statistic] = [] //display the data from coin
    @Published var additionalStatics:[Statistic] = []// display the data from coindetail
    @Published var coinWebsite:String? = ""
    
    
    init(coin: Coin) {
    
        self.coin = coin
        self.addSubscribers()
        
    }
    
    func addSubscribers() {
        
        self.coinDetailDataService = CoinDetialDataService(coin: coin)
        
        coinDetailDataService?.$coinDetail
            .combineLatest(self.$coin)
            .map({ (coinDetail, coin) -> (overview:[Statistic], additional:[Statistic]) in
                //Overview
                let overview = self.transformDataIntoOverviewArray(with: coin)
                //additional
                let additional = self.transformDataIntoAdditionalArray(with: coin, coinDetail: coinDetail)
                
                return (overview,additional)
            })
            .sink(receiveValue: { [weak self] returnedArrayFromMap in
                
                guard let self = self else { return }
                self.overviewStatics = returnedArrayFromMap.overview
                self.additionalStatics = returnedArrayFromMap.additional
//                self.description = returnedArrayFromMap.additional.
            })
            .store(in: &cancellables)
        
        
        coinDetailDataService?.$coinDetail
            .sink(receiveValue: { [weak self] returnCoinDetail in
                guard let self = self else { return }
//                self.description = returnCoinDetail?.description?.en ?? "Description for \(returnCoinDetail?.name)"
                self.downloadedCoinDetail = returnCoinDetail
                self.coinWebsite = returnCoinDetail?.links?.homepage?.first
            }).store(in: &cancellables)
        
        
    }
    
    
    private func transformDataIntoOverviewArray(with coin:Coin) -> [Statistic] {
        
        let price = coin.currentPrice.asCurrencyStringWith6Decimals()
        let pricePercentChange = coin.priceChangePercentage24H
        let priceStatistic = Statistic(title: "Current Price", value: price, percentageChange: pricePercentChange)
        
        let marketCap = "$" + (coin.marketCap?.formattedWithAbbreviations() ?? "nil")
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        let marketCapStatistic = Statistic(title: "Market Cap.", value: marketCap, percentageChange: marketCapPercentChange)
        
        let rank = String(coin.rank)
        let rankStatistic = Statistic(title: "Rank", value: rank)
        
        let volumn = coin.totalVolume?.formattedWithAbbreviations() ?? "nil"
        let volumnStatistic = Statistic(title: "Volumn", value: volumn)
        
        return [priceStatistic, marketCapStatistic, rankStatistic, volumnStatistic]
        
    }
    
    private func transformDataIntoAdditionalArray(with coin:Coin, coinDetail:CoinDetail?) -> [Statistic] {
        
        let high = coin.high24H?.asCurrencyStringWith6Decimals() ?? "n/a"
        let highStat = Statistic(title: "24h High", value: high)
        
        let low = coin.low24H?.asCurrencyStringWith6Decimals() ?? "n/a"
        let lowStat = Statistic(title: "24h Low", value: low)
        
        let priceChange = coin.priceChange24H?.asCurrencyStringWith6Decimals() ?? "n/a"
        let pricePercentChangeA = coin.priceChangePercentage24H
        let priceChangeStat = Statistic(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChangeA)
        
        let marketCapChange = "$" + (coin.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChangeA = coin.marketCapChangePercentage24H
        let marketCapChangeStat = Statistic(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChangeA)
        
        let blockTime = coinDetail?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = Statistic(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetail?.hashingAlgorithm ?? "n/a"
        let hashingStat = Statistic(title: "Hashing Algorithm", value: hashing)
        
        return [highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingStat]
        
    }
    
    
    
}
