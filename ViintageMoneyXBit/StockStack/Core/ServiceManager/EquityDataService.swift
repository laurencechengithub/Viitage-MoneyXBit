//
//  EquityDataService.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/8/8.
//

import Foundation
import Combine

class EquityDataService {
    
    @Published var searchEquityResult:[Equity] = []
    var equitySubscription:AnyCancellable?
    
//    init(keyword:String) {
//        searchEquity(using: keyword)
//    }
    
    init() {
    
    }
    
    func searchEquity(using keyword:String) {
        
        guard let url = URL(string: "\(URLManager.alphavantageQuery)function=SYMBOL_SEARCH&keywords=\(keyword)&apikey=\(URLManager.stockApiKey)") else {
            return
        }
        
        equitySubscription = NetworkManager.download(url: url )
            .decode(type: SearchEquity.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { complete in
                switch complete {
                case .finished:
                    print("complete")
                    
                    break
                case .failure(let err):
                    print("Search Equity failed with Error: \(err)")
                }
            }, receiveValue: { [weak self] downloadedData in
                guard let self = self else { return }
                self.searchEquityResult = downloadedData.bestMatches
                self.equitySubscription?.cancel()

            })
    }
    
}
