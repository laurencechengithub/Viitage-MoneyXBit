//
//  CoinDetailView.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/27.
//

import SwiftUI

//Not using uikit write as below
//struct CoinDetailView: View {
//    @StateObject var viewmodel: CoinDetailViewModel
//    init(coin : Coin) {
//        _viewModel = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
//}


//using uikit navi for creating this CoinDetailView

struct CoinDetailView: View {
    //give below EnvironmentObject from coinFlowVC
    @EnvironmentObject var coinFlowController : CoinFlowController
    @EnvironmentObject var viewModel : CoinDetailViewModel
    
    private let overviewGridColumns:[GridItem] = [GridItem(.flexible()),
                                                  GridItem(.flexible())]
    
    @State private var showDes = false
    
    init() {}
    
    var body: some View {
        ScrollView {
            VStack (alignment:.leading,spacing: 10) {
                NaviTitleView
                CoinImageView(with: viewModel.coin)
                    .frame(width: 30, height: 30, alignment: .center)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                CoinChartView(coin: viewModel.coin)
                Spacer()
                overviewTitleAndGrid
                Divider()
                additionalTitleAndDrid
                HStack {
                    if let website = viewModel.coinWebsite,
                       let url = URL(string: website) {
                        Link(destination: url) {
                            Image(systemName: "network")
                                .font(.system(size: 24, weight: .heavy, design: .rounded))
                        }
                    }

                }
            }.padding()
      
            
        }
        
        
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {

        Group {
            CoinDetailView()
                .environmentObject(CoinDetailViewModel(coin: devPreview.fakeCoin))
                .preferredColorScheme(.dark)
            
            CoinDetailView()
                .environmentObject(CoinDetailViewModel(coin: devPreview.fakeCoin))
        
        }
        

    }
}



extension CoinDetailView {
    
    private var NaviTitleView: some View {
        
        HStack {
            Text("\(viewModel.coin.name)")
                .font(.system(size: 52, weight: .bold, design: .rounded))
                .foregroundColor(Color.theme.accent)
            Spacer()
            Button {
                crossBtnTapped()
            } label: {
                Image(systemName: "xmark")
            }
        }
        
    }
    
    
    private var overviewTitleAndGrid: some View {
        
        VStack (alignment: .leading, spacing: 10) {
            Text("Overview")
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .foregroundColor(Color.theme.accent)
            
            descriptionView

            LazyVGrid(columns: overviewGridColumns,
                      alignment: .leading,
                      spacing: 20,
                      pinnedViews: []) {
                ForEach(viewModel.overviewStatics) { eachStatic in
                    StatisticView(statistic: eachStatic)
                }
            }
        }

    }
    
    private var additionalTitleAndDrid:some View {
        
        VStack (alignment: .leading, spacing: 10) {
            Text("Additional Details")
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .foregroundColor(Color.theme.accent)
            LazyVGrid(columns: overviewGridColumns,
                      alignment: .leading,
                      spacing: 20,
                      pinnedViews: []) {
                ForEach(viewModel.additionalStatics) { eachStatic in
                    StatisticView(statistic: eachStatic)
                }
            }
        }
    }
    
    private var descriptionView:some View {
        
        ZStack {
            VStack (alignment:.leading, spacing: 6){
                if let detail = viewModel.downloadedCoinDetail,
                    let des = detail.description {
                    Text(des.en?.removingHTMLOccurances ?? "")
                        .font(.system(size: 14, weight: .light, design: .rounded))
                        .foregroundColor(Color.theme.secondaryText)
                        .lineLimit(self.showDes == false ? 3 : nil)
                }
                Button {
                    withAnimation (.easeInOut) {
                        self.showDes.toggle()
                    }
                    
                } label: {
                    Text(self.showDes == false ? "Read more..." : "Less")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundColor(.blue)
                }
            }.padding(.vertical)
        }
        
    }
    
    
    private func crossBtnTapped() {
        coinFlowController.dismissCurrentView()
    }
    
    
}
