//
//  CoinStatisticView.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/15.
//

import SwiftUI

struct CoinStatisticView: View {
    
    @ObservedObject var CoinViewModel : CoinViewModel
    @Binding var isPortfolioShowing : Bool
    
    var body: some View {
        HStack (alignment: .center, spacing: 4) {
            
            ForEach(CoinViewModel.statistics) { stat in
                StatisticView(statistic: stat)
                // since we are at portiate mode only, so below uiscreen...width will work
                // if landscape, will need geo reader
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
            
        }
        .padding(EdgeInsets.init(top: 0, leading: 10, bottom: 0, trailing: 10))
        .frame(width: UIScreen.main.bounds.width,
               alignment: isPortfolioShowing ? .trailing : .leading)
        // this makes sure that the hstack will stay inside the screen
        // since the Hstack is wider than the screen
        //
        // depends on the isPortfolioShowing, when it's true than the alignment differ and
        // SwiftUI will handle the views it self
    }
}

struct CoinStatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            CoinStatisticView(CoinViewModel: devPreview.coinViewModel, isPortfolioShowing: .constant(true))
                .preferredColorScheme(.dark)

            
            CoinStatisticView(CoinViewModel: devPreview.coinViewModel, isPortfolioShowing: .constant(false))
                .preferredColorScheme(.light)

            
            
        }
        
        
    }
}
