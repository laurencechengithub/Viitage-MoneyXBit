//
//  StockDetailViewModel.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/8/10.
//

import Foundation
import Combine

class StockDetailViewModel: ObservableObject {
    
    @Published var openHistory  :[Double] = []
    @Published var volumnHistory:[Double] = []
    @Published var quote  :Quote? = nil
    
    private var intradayDataService:IntradayDataService?
    private var quoteDataService : QuoteDataService?
    var equity:Equity
    private var cancellables = Set<AnyCancellable>()
    var equityName:String
    
    init(equity:Equity) {
        self.equity = equity
        self.equityName = equity.the2Name
        subscribeToIntradayQuotes()
        subscribeToQuote()
    }
    
    func subscribeToIntradayQuotes() {
        
        intradayDataService = IntradayDataService(equity: equity)

        intradayDataService?.$timeSeries60m
            .sink(receiveValue: { [weak self] dataOftimeSeries60m in
                
                guard let self = self else {
                    return
                }
                
                _ = dataOftimeSeries60m.map { eachTimeSeries in
                    let open = Double(eachTimeSeries.the1Open) ?? 0.0
                    self.openHistory.append(open)
                    let vol = Double(eachTimeSeries.the5Volume) ?? 0.0
                    self.volumnHistory.append(vol)
                }
                
            }).store(in: &cancellables)
    }
    
    func subscribeToQuote() {
        
        quoteDataService = QuoteDataService(symbol: equity.the1Symbol)
        
        quoteDataService?.$quote
        //sink to observe values received by the publisher
            .sink { [weak self] (quoteFromService) in
                guard let self = self, let quote = quoteFromService  else {
                    return
                }
                self.quote = quote
            }
            .store(in: &cancellables)
    }
    
}
