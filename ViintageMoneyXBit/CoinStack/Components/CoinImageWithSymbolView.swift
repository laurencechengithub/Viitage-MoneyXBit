//
//  CoinImageWithSymbolView.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/20.
//

import SwiftUI

struct CoinImageWithSymbolView: View {
    
    let coin: Coin
    
    var body: some View {
        VStack (alignment: .center, spacing: 4) {
            CoinImageView(with: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.system(size: 20, weight: .light, design: .rounded))
                .foregroundColor(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

struct CoinImageWithSymbolView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            
            CoinImageWithSymbolView(coin: devPreview.fakeCoin)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
            
            CoinImageWithSymbolView(coin: devPreview.fakeCoin)
                .previewLayout(.sizeThatFits)
        }
      
    }
}
