//
//  IntradayDataService.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/8/11.
//

import Foundation
import Combine

class IntradayDataService {
    
    @Published var timeSeries60m:[TimeSeries60Min] = []
    
    private var equityName:String
    private var symbol:String
    private var intradayDataSubscription:AnyCancellable?
    
    init(equity: Equity) {
        self.equityName = equity.the2Name
        self.symbol = equity.the1Symbol
        getIntradayQuotesWith()
    }
    
    
    func getIntradayQuotesWith() {
        
        guard let intradayUrl = URL(string: "\(URLManager.alphavantageQuery)function=TIME_SERIES_INTRADAY&symbol=\(symbol)&interval=60min&outputsize=compact&apikey=\(URLManager.stockApiKey)") else { return }
        
        print("intradayUrl \(intradayUrl)")
        
        intradayDataSubscription = NetworkManager.download(url: intradayUrl)
            .decode(type: QuoteIntraday.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished :
                    print("getIntradayQuotesWith complete")
                case .failure(let error) :
                    print("getIntradayQuotesWith fail with \(error)")
                }
            } receiveValue: { decodedData in
                
                var unSortedDictionary = [String:TimeSeries60Min]()
                decodedData.timeSeries60Min.forEach({ (key,value) in
                    
                    if key.contains("20:00") || key.contains("06:00") {
                        unSortedDictionary.updateValue(value, forKey: key)
                    }
                })

                let sortedDictionary = unSortedDictionary.keys.sorted(by: <).map({unSortedDictionary[$0]!})
                self.timeSeries60m = sortedDictionary
                self.intradayDataSubscription?.cancel()
            }
    }
    
    
}


