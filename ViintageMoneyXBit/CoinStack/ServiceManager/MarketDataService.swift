//
//  MarketDataService.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/18.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var market:Market? = nil
    var marketDataSubcription: AnyCancellable?
    
    init() {
        getMarketData()
    }
    
    func getMarketData() {
        
        guard let url = URL(string: URLManager.getMarket) else { return }

        marketDataSubcription = NetworkManager.download(url: url)
                .decode(type: MarketData.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (returnedData) in
                    guard let self = self else {
                        return
                    }
                    self.market = returnedData.data
                    self.marketDataSubcription?.cancel()
                    // cancel()
                    // implement cancel() to request that your publisher stop calling its downstream subscribers
                    // Canceling should also eliminate any strong references it currently holds.
                })
        }
    
    
}
