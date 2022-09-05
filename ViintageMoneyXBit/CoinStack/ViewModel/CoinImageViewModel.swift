//
//  CoinImageViewModel.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/8.
//

import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image:UIImage? = nil
    @Published var isLoading: Bool = false
    
    private var coinImageService : CoinImageService!
    private var coin : Coin!
    private var cancellable = Set<AnyCancellable>()
    
    init(with coin:Coin) {
        self.coin = coin
        self.isLoading = true
        getCoinImage()
    }
    
    private func getCoinImage() {
        
        self.coinImageService = CoinImageService(with: coin)
        
        coinImageService.$downLoadedImage
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                
            } receiveValue: { receivedValue in
                
                self.image = receivedValue
                //an object that implements Cancellable has a cancel method that we can call to stop any in progress work, any allocated resources to be freed up
                //An AnyCancellable instance automatically calls cancel() when deinitialized.
                //and run the 
                
            }.store(in: &cancellable)

    }
}
