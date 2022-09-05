//
//  CoinView.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/7.
//

import SwiftUI

struct CoinView: View {
    
    @EnvironmentObject private var coinFlowController: CoinFlowController
    @EnvironmentObject private var viewModel : CoinViewModel
    
    @State private var isShowPortfolio: Bool = false //btn toggle
    //comment#1
    //@State private var isShowPortfolioView: Bool = false//show view
    
    var body: some View {
            ZStack {
                Color.theme.bg
                    .ignoresSafeArea()
                // comment#1
                // since we are using uikit navigation to navi to
                // CoinPortfolioView, below code are not required
//                    .sheet(isPresented: $isShowPortfolioView) {
//                        CoinPortfolioView()
//                            .environmentObject(viewModel)
//                    }

                VStack {
                    homeHeader
                    CoinStatisticView(CoinViewModel: viewModel, isPortfolioShowing: $isShowPortfolio)
    //                columnTitles
                    SearchBarView(searchText: $viewModel.searchText)
                    columnTitles
                    if isShowPortfolio == true {
                        
                        ZStack {
                            if viewModel.portfolioCoins.isEmpty && viewModel.searchText.isEmpty {
                                Text("Ooooops! you have nothing inside your portfolio 😁! please jump back and start adding coins or stock into this portfolio")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                            } else {
                                portfolioCoinsList
                            }
                        }.transition(.move(edge: .trailing)) //從左邊滑入對齊右邊
                        
         
                        
                    } else {
                        allCoinsList
                    }
                    Spacer(minLength: 0)
                }
            }
    }
}

struct CoinView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CoinView()
                .environmentObject(devPreview.coinViewModel)
                .navigationBarHidden(true)
          }
    }
}


extension CoinView {
    
    private var homeHeader: some View {
        
        HStack {
            //MARK : left navi button
            CircleBtnView(iconName: isShowPortfolio ? "plus" : "info")
                .animation(.none)
                .onTapGesture {
                    if isShowPortfolio {
//                        isShowPortfolio.toggle()
//                        isShowPortfolioView.toggle()
                        print("isShowPortfolio = true")
                        coinFlowController.showCoinPortfolioView()
                    } else {
//                        isShowPortfolio.toggle()
                        print("isShowPortfolio = false")
                        coinFlowController.showSettingView()
                    }
                }
                .background(
                    CircleBtnAnimationViewEffect(isAnimate: $isShowPortfolio)
                )
            Spacer()
            // MARK: Middle navi title
            Text(isShowPortfolio ? "Portfolio" : "Live Prices")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            // MARK: right navi button
            CircleBtnView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: isShowPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        isShowPortfolio.toggle()
                    }
                }
        }
//        .padding(.horizontal)
    }
        
    private var allCoinsList: some View {
        List {
            ForEach(viewModel.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .listRowBackground(Color.theme.bg)
                    .onTapGesture {
                        coinFlowController.showCoinDetailView(with: coin)
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(viewModel.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
            }.listRowInsets(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 20))
            
            
            
            
//            ForEach(viewModel.portfolioCoins) { coin in
//                CoinRowView(coin: coin, showHoldingsColumn: true)
//                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
//                    .onTapGesture {
//                        segue(coin: coin)
//                    }
//                    .listRowBackground(Color.theme.bg)
//            }
        }
        .listStyle(PlainListStyle())
    }
    
    
    
    private var columnTitles: some View {
         HStack {
             HStack(spacing: 4) {
                 Text("Coin")
                 Image(systemName: "chevron.down")
                     .opacity(viewModel.sortingType == .rank || viewModel.sortingType == .rankReversed ? 1.0 : 0.0  )
                     .rotationEffect(Angle(degrees: viewModel.sortingType == .rank ? 0 : 180))
             }
             .onTapGesture {

                 withAnimation(.default) {
                     viewModel.sortingType = viewModel.sortingType == .rank ? .rankReversed : .rank
                 }
             }

             Spacer()
             if isShowPortfolio {
                 HStack(alignment:.center ,spacing: 4) {
                     Text("Holdings")
                     Image(systemName: "chevron.down")
                         .opacity((viewModel.sortingType == .holdings || viewModel.sortingType == .holdingReversed) ? 1.0 : 0.0)
                         .rotationEffect(Angle(degrees: viewModel.sortingType == .holdings ? 0 : 180))
                 }
                 .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                 .onTapGesture {
                     withAnimation(.default) {
                         viewModel.sortingType = viewModel.sortingType == .holdings ? .holdingReversed : .holdings
                     }
                 }
             }
  
             HStack(spacing: 4) {
                 Text("Price")
                 Image(systemName: "chevron.down")
                     .opacity((viewModel.sortingType == .price || viewModel.sortingType == .priceReversed) ? 1.0 : 0.0)
                     .rotationEffect(Angle(degrees: viewModel.sortingType == .price ? 0 : 180))
             }
//             .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
             .onTapGesture {
                 withAnimation(.default) {
                     viewModel.sortingType = viewModel.sortingType == .price ? .priceReversed : .price
                 }
             }

             Button(action: {
                 withAnimation(.linear(duration: 2.0)) {
                     viewModel.reloadCloinData()
                 }
             }, label: {
                 Image(systemName: "goforward")
             })
             .rotationEffect(Angle(degrees: viewModel.isLoading ? 360 : 0),anchor: .center)
         }
         .font(.system(size: 16, weight: .heavy, design: .rounded))
         .foregroundColor(Color.theme.secondaryText)
         .padding(.horizontal)
     }
    
    
}
