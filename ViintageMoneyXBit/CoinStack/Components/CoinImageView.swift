//
//  CoinImageView.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/8.
//

import SwiftUI


struct CoinImageView: View {
    
    @StateObject var coinImageViewModel : CoinImageViewModel
    
    init(with coin:Coin) {
        _coinImageViewModel = StateObject(wrappedValue: CoinImageViewModel(with: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = coinImageViewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if coinImageViewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
        
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(with: devPreview.fakeCoin)
    }
}
