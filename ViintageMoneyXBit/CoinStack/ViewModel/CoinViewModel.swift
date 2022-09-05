//
//  CoinViewModel.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/7.
//

import Foundation
import Combine
import SwiftUI

class CoinViewModel:ObservableObject {
    

    @Published var searchText: String = ""
    private var subcriptionCancellables = Set<AnyCancellable>()
    
    //allCoins
    @Published var allCoins:[Coin] = []
    private var coinDataService = CoinDataService()
//    private var coinSubcription = Set<AnyCancellable>()
    
    //Statistic
    @Published var statistics:[Statistic] = []
    private var marketDataService = MarketDataService()
//    private var marketdataSubcription = Set<AnyCancellable>()
    
    //Portfolio
    @Published var portfolioCoins:[Coin] = []
    private var portfolioDataService = PortfolioDataService()
    
    @Published var isLoading = false
    
    //Sorting
    enum SortOption {
        case rank, rankReversed, holdings, holdingReversed, price, priceReversed
    }
    @Published var sortingType:SortOption = .rank
    
    
    init() {
        addSubscriber()
    }
    
    
    func addSubscriber() {
        coinsAndSearchCoinSubscriber()
        portfolioSubcriber()
        marketDataSubscriber()
   
    }
    
    
    func coinsAndSearchCoinSubscriber() {
        //    subscribeToCoinService method 結合到下方 search text
        //    func subscribeToCoinService() {
            
        //        coinDataService.$allCoins
        //            .sink { [weak self] coinFromDataService in
        //                guard let self = self else { return }
        //                self.allCoins = coinFromDataService
        //            }.store(in: &coinSubcription)
                
        //    }
        
        $searchText // ##Step0## searchText,allCoins,sortType when the three updates will trigger this subscriber
            .combineLatest(coinDataService.$allCoins, $sortingType)
            //combineLatest =>
            //to be subscribed to another besides $searchText ( + $allCoins )
            //when either the $searchText or $allCoins (both are subscriber) has changed
            //we'll be noticed
    
            .map { (stringFromSearchText, arrayOfCoinsFromCoinDataService, sortType) -> [Coin] in
                
                guard stringFromSearchText.isEmpty == false else {
                    // no need to perform filter
                    //(當無字串收尋時就是allCoins)
                    var filterCoin:[Coin] = arrayOfCoinsFromCoinDataService //原本arrayOfCoinsFromCoinDataService是一個不可變參數
                    self.sortCoins(with: sortType, coins: &filterCoin)
                    return filterCoin
                }
                
                let lowerCasedText = stringFromSearchText.lowercased()
                var filterdCoins = arrayOfCoinsFromCoinDataService.filter { (coin) in
                    coin.name.lowercased().contains(lowerCasedText) || //this sign || sound like pips
                    coin.symbol.lowercased().contains(lowerCasedText) ||
                    coin.id.lowercased().contains(lowerCasedText)
                }
                self.sortCoins(with: sortType, coins: &filterdCoins)
                return filterdCoins
            }
            //map=>
            //transform what we received from publisher into some kind of data
            .sink { coinsReturnedFromMapResult in
                self.allCoins = coinsReturnedFromMapResult
                // ##Step1## allcoin are updates
            }
            .store(in: &subcriptionCancellables)
    }
    
    func portfolioSubcriber() {
        
        $allCoins // ##Step2## after allcoin are updated, this subcriber are triggered
            .combineLatest(portfolioDataService.$savedEntities)
            .map { (theFilterCoinsArray, portFolioEntitiesArray) -> [Coin] in
                
                //look through all the coins in the theFilterCoinsArray to see
                //any of those are included in the portFolioEntities and return them
                //but for those are not inside portFolioEntitiesArray should return nil
                theFilterCoinsArray
                    .compactMap { (coin) -> Coin? in
                        guard let entity = portFolioEntitiesArray.first(where: { $0.coinID == coin.id }) else {
                            //cant find the entity meaning not in portFolio
                            return nil
                        }
                        //find the coin inside portFolioEntitiesArray
                        //we return the coin with the updated holding amount
                        return coin.updateHoldings(amount: entity.amount)
                    }
            }
            .sink { [weak self] coinsReturedFromCompactMapResult in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinIfNeeded(with: coinsReturedFromCompactMapResult)
                // ##Step3## portfolioCoins are update
            }
            .store(in: &subcriptionCancellables)
        
    }
    
    
    func marketDataSubscriber() {
        
        marketDataService.$market // ##Step4## after portfolioCoins are updated trigger (combinelatest)
            .combineLatest($portfolioCoins) //subscrib to $portfolioCoins need to make sure $portfolioCoins are updated belore this subscribion
            .map { (marketDataFromDataService, portfolioCoinsArray) -> [Statistic] in
                var status = [Statistic]()
                guard let marketData = marketDataFromDataService else {
                    return status
                }
                
                let usdMarketCapStatistics = Statistic(title: "USD Market Cap",
                                                       value: marketData.USDMarketCap,
                                                       percentageChange: marketData.marketCapChangePercentage24HUsd)
                let volume = Statistic(title: "USD 24h Volume",
                                       value: marketData.USDVolume)
                let btcStatics = Statistic(title: "BTC %",
                                           value: marketData.btcDominancePercentage)

                //Below calculate the total volumn of portfolio coin that user have
                let totalPortfolioHolding = portfolioCoinsArray.map { (eachCoin) -> Double in
                    eachCoin.currentHoldingsAsValue
                }.reduce(0, +)
                // reduce => the sum, the 0 => starting value, + add those all together
                
                //Below calculate the total volumn of portfolio coin that user had 24h ago
                let totalPortfolioHolding24hAgo = portfolioCoinsArray.map({ (eachCoin) -> Double in
                    let valueNow = eachCoin.currentHoldingsAsValue
                    let valueChangeInDecimo = ( eachCoin.priceChangePercentage24H ?? 0.0 ) / 100
                    let previousValue = valueNow / ( 1 + valueChangeInDecimo)
                    return previousValue
                }).reduce(0, +)
                
                let percetageChange = ((totalPortfolioHolding - totalPortfolioHolding24hAgo) / totalPortfolioHolding24hAgo) * 100
                
                
                
                let portfolio = Statistic(title: "Portfolio Value", value: totalPortfolioHolding.asCurrencyWith2Decimals(), percentageChange: percetageChange)
                status.append(contentsOf: [usdMarketCapStatistics,volume,btcStatics,portfolio])
                return status
            }.sink { [weak self] statusFromMapResult in
                guard let self = self else { return }
                self.statistics = statusFromMapResult
                // ##Step5## statistics are updated
                self.isLoading = false
            }.store(in: &subcriptionCancellables)
    }
    
    
    
    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    //更新coin price and market price
    func reloadCloinData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getMarketData()
        HapticManager.notification(type: .success) //震動效果
    }
    
    //sorting
    
    // func sortCoins(with type:SortOption, coin:[Coin]) -> [Coin] {
    
    // more effeciently we can user inout => mean take the coins in and throw it out again
    // this could save memory and not returning a new [Coin]
    
    func sortCoins(with type:SortOption, coins: inout [Coin]) {
        switch type {
        case .rank , .holdings:
//            coins.sorted { (coin1, coin2) -> Bool in
//                coin1.rank < coin2.rank
//            }
            coins.sort { (coin1, coin2) -> Bool in
                coin1.rank < coin2.rank
            }
        case .rankReversed , .holdingReversed:
//            coins.sorted(by: { $0.rank > $1.rank })
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
//            coins.sorted(by: { $0.currentPrice > $1.currentPrice })
            coins.sort(by: { $0.currentPrice > $1.currentPrice })
        case .priceReversed:
//            coins.sorted(by: { $0.currentPrice < $1.currentPrice })
            coins.sort(by: { $0.currentPrice < $1.currentPrice })
        }
        
    }
    
    func sortPortfolioCoinIfNeeded(with coins: [Coin]) -> [Coin] {
        
        switch sortingType {
        case .holdings:
            let arrangedCoins = coins.sorted(by: {
                $0.currentHoldingsAsValue > $1.currentHoldingsAsValue
            })
            return arrangedCoins
        case .holdingReversed:
            return coins.sorted(by: {
                $0.currentHoldingsAsValue < $1.currentHoldingsAsValue
            })
        default:
            return coins
        }
    }
    
    
}

