//
//  CoinPortfolioView.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/19.
//

import SwiftUI

struct CoinPortfolioView: View {
    
    @EnvironmentObject private var coinFlow:CoinFlowController
    @EnvironmentObject private var viewModel:CoinViewModel
    
    @State private var selectedCoin: Coin? = nil
    @State private var quantityTextFieldInput : String = ""
    @State private var isShowSaveProfolio = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Edit \nPortFolio")
                    .foregroundColor(Color.theme.accent)
                    .minimumScaleFactor(0.8)
                    .font(.system(size: 52, weight: .bold, design: .rounded))
                    .lineLimit(2)
                    .padding(.leading)
                Spacer()
                VStack {
                    Button {
                        coinFlow.dismissCurrentView()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 60, trailing: 20))
                    Button {
                        saveButtonTapped()
                        //do something here
                    } label: {
                        Image(systemName: "folder.badge.plus")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 20))
                    .opacity( (selectedCoin != nil && quantityTextFieldInput != "") ? 1.0 : 0 )
                    .alert(isPresented: $isShowSaveProfolio) {
                        Alert(title: Text("ViintageExchange"),
                              message: Text("Save to Portolio"),
                              dismissButton: .cancel(Text("Got it")))
                    }
                }
            }
            Divider()
            ScrollView {
                SearchBarView(searchText: $viewModel.searchText)
                coinList
                Divider()
                if selectedCoin != nil, let coin = selectedCoin {
                    VStack(spacing: 20) {
                        HStack {
                            Text("Current price of " + "\(coin.symbol.uppercased()) :" )
                            Spacer()
                            Text(coin.currentPrice.asCurrencyStringWith6Decimals())
                        }
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                        HStack (spacing:0) {
                            Text("Amount in your holding :")
                                .fixedSize()
                            Spacer()
                            TextField("ex: 20.1", text: $quantityTextFieldInput)
                                .multilineTextAlignment(.trailing)
                                .keyboardType(.decimalPad)
                        }
                        Divider()
                        HStack {
                            Text("Current Value :")
                            Spacer()
                            Text(getCurrentValue().asCurrencyWith2Decimals())
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                }
                
            }
            //當點擊search field 的 x 會清除 viewModel.searchText
            //下面監聽這個 令他為 value 如有變成 “” 就做 removeSelectedCoin()
            .onChange(of: viewModel.searchText) { value in
                if value == "" {
                    removeSelectedCoin()
                }
            }
            
        }

    }
}

struct CoinPortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        CoinPortfolioView().environmentObject(devPreview.coinViewModel)
    }
}

extension CoinPortfolioView {
    
    private var coinList: some View {
        
        ScrollView (.horizontal, showsIndicators: true) {
            LazyHStack(spacing: 10) {
                ForEach(viewModel.allCoins) { coin in
                    CoinImageWithSymbolView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            didTapPortfolioWith(selectedCoin: coin)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    selectedCoin?.name == coin.name ?
                                    Color.theme.green : Color.clear,
                                    lineWidth: 1
                                )
                        )
                }
            }
        }
        
    }
    
    private func getCurrentValue() -> Double {
        if let qty = Double(quantityTextFieldInput) {
            return qty * (selectedCoin?.currentPrice ?? 0.0)
        }
        return 0.0
    }
    
    
    private func saveButtonTapped() {
        
        guard let coin = selectedCoin, let holdAmount = Double(quantityTextFieldInput) else { return }
        //save to portfolio
        viewModel.updatePortfolio(coin: coin, amount: holdAmount)
        //remove selected
        removeSelectedCoin()
        //hide keyboard
        UIApplication.shared.endEditing()
        //show alert
        isShowSaveProfolio.toggle()
        
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        viewModel.searchText = ""
    }
    
    
    private func didTapPortfolioWith(selectedCoin:Coin) {
        self.selectedCoin = selectedCoin
        guard let portFolioCoin = viewModel.portfolioCoins.first(where: {$0.id == selectedCoin.id }) else {
            quantityTextFieldInput = ""
            return
        }
        
        quantityTextFieldInput = "\(portFolioCoin.currentHoldings ?? 0.0)"
        
    }
    
}
