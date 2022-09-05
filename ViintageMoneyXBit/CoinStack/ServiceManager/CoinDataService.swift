//
//  CoinDataService.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/7.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins:[Coin] = []
    var coinSubcription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        
        guard let url = URL(string: URLManager.getCoins) else { return }

        coinSubcription = NetworkManager.download(url: url)
                .decode(type: [Coin].self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                    guard let self = self else {
                        return
                    }
                    self.allCoins = returnedCoins
                    self.coinSubcription?.cancel()
                })
        }
    
    
}
