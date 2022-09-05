//
//  CoinRowView.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/7.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: Coin
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack {
            leftColumn
            Spacer()
            if showHoldingsColumn {
                centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
        .background(
            Color.theme.bg.opacity(0.01)
        )
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: devPreview.fakeCoin, showHoldingsColumn: true)
            .previewLayout(.sizeThatFits)
    }
}

extension CoinRowView {
    
    private var leftColumn: some View {
            HStack(spacing: 0) {
                Text("\(coin.rank)")
                    .font(.caption)
                    .foregroundColor(Color.theme.secondaryText)
                    .frame(minWidth: 30)
                CoinImageView(with: self.coin)
                    .frame(width: 30, height: 30)
//                Circle()
//                    .frame(width: 30, height: 30)
                Text(coin.symbol.uppercased())
                    .font(.headline)
                    .padding(.leading, 6)
                    .foregroundColor(Color.theme.accent)
            }
        }
        
        private var centerColumn: some View {
            VStack(alignment: .trailing) {
                Text(coin.currentHoldingsAsValue.asCurrencyWith2Decimals())
                    .bold()
                Text((coin.currentHoldings ?? 0).asDoubleString(roundTo: 2))
            }
            .foregroundColor(Color.theme.accent)
        }
        
        private var rightColumn: some View {
            VStack(alignment: .trailing) {
                Text(coin.currentPrice.asCurrencyStringWith6Decimals())
                    .bold()
                    .foregroundColor(Color.theme.accent)
                Text(coin.priceChangePercentage24H?.asPercentStringAndRoundTo2() ?? "")
                    .foregroundColor(
                        (coin.priceChangePercentage24H ?? 0 >= 0) ?
                        Color.theme.green :
                        Color.theme.red
                    )
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
    
}
