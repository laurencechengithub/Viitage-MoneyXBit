//
//  HomeViewModel.swift
//  ViitageEX
//
//  Created by LaurenceMBP2 on 2022/7/4.
//

import Foundation
import Combine

class StockViewModel: ObservableObject {
    
    @Published var quoteIntraday:[QuoteIntraday] = []
    @Published var equities:[Equity] = []
    @Published var pinList:[Equity] = []
    
    //    @Published var searchBtnTapped:Bool = false
    var userSearchText:String = ""
 
    private var equityDataService = EquityDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSearchingForEquitySubscriber()
    }
    
    func addSearchingForEquitySubscriber() {
        
//        $searchText
//            .combineLatest(equityDataService.$searchEquityResult)
//            .map { (userSearchString, searchEquityResult) -> [Equity] in
//                if userSearchString.isEmpty {
//                    print("userSearchString is empty")
//                    return []
//                } else {
//                    self.equityDataService.searchEquity(using: userSearchString)
//                    return searchEquityResult
//                }
//
//            }
//            .sink { [weak self] returnedArrayFromMap in
//                guard let self = self else { return }
//                self.equities = returnedArrayFromMap
//            }
//            .store(in: &cancellables)

//        $searchBtnTapped
//            .sink { userEnteredString in
//                if userEnteredString.isEmpty {
//                    print("userSearchString is empty")
//                } else {
//                    self.equityDataService.searchEquity(using: userEnteredString)
//                }
//            }.store(in: &cancellables)
        
        
        
        equityDataService.$searchEquityResult
            .sink { equityArray in
                self.equities = equityArray
            }.store(in: &cancellables)
        
        
    }
    
    func searchWith(text:String) {
        self.equityDataService.searchEquity(using: text)
    }
    
    
    
    
}
