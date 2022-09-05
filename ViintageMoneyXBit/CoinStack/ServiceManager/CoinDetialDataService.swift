//
//  CoinDetialDataService.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/27.
//

import Foundation
import Combine

class CoinDetialDataService {
    
    @Published var coinDetail:CoinDetail? = nil
    private var coinDetailSubcription: AnyCancellable?
    var coin:Coin
    
    init(coin:Coin) {
        self.coin = coin
        getCoinDetail(with: coin)
    }
    
    func getCoinDetail(with detailCoin: Coin) {
        
        guard let url = URL(string: "\(URLManager.getCoinDetailPrefix)\(detailCoin.id)") else { return }
        
        coinDetailSubcription = NetworkManager.download(url: url)
            .decode(type: CoinDetail.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main) //receive it on main thread
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] returnCoinDetail in
                guard let self = self else { return }
                self.coinDetail = returnCoinDetail
                self.coinDetailSubcription?.cancel()
            })
        
        
        
    }
    
}
