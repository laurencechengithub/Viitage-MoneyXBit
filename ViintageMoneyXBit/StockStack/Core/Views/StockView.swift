//
//  StockView.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/6.
//

import SwiftUI

struct StockView: View {
        @EnvironmentObject private var viewModel:StockViewModel
        @EnvironmentObject private var stockFlowController:StockFlowController

        @State private var isShowPortfolio: Bool = false
        @State private var searchText:String = ""
        
        init() {
    //        UITableView.appearance().backgroundColor = UIColor.lightGray
        }
        
        var body: some View {
            ZStack{
                Color.theme.bg.ignoresSafeArea()
                VStack {
                    homeHeader
                    searchAndButtonView
                    titleBar
                    
                    if isShowPortfolio == false {
                        ZStack (alignment: .center){
                            
                            if self.searchText.isEmpty {
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(width: UIScreen.main.bounds.width, height: 200)
                                    .foregroundColor(Color.gray.opacity(0.5))
                                    .opacity(0.2)
                                    .padding()
                                
                                Text("Hey! Start by entering the equity symbol that you wish to search!!")
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .lineLimit(2)
                                    .minimumScaleFactor(0.8)
                                    .foregroundColor(Color.white)
                                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                            } else {
                                List {
                                    ForEach(viewModel.equities) { eachEquity in
                                        EquityRowView(equity: eachEquity)
                                            .onTapGesture {
                                                stockFlowController.showStockDetailView(with: eachEquity)
                                            }
                                    }
                                }
                            }
  
                        }
                    } else {
                        //TBD
                    }
                    Spacer(minLength: 0)
                }
                .frame(width: UIScreen.main.bounds.width)
                
            }
        }
        
}

extension StockView {
    
    private var homeHeader: some View {
        
        HStack{
            CircleBtnView(iconName: isShowPortfolio ? "plus" : "info" )
                .transaction { theTransaction in
                    theTransaction.animation = nil
                }
                .background(
                    CircleBtnAnimationViewEffect(isAnimate: $isShowPortfolio)
                )
            Spacer()
            Text(isShowPortfolio ? "My Portfolio" : "Daily Quote")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .transaction { trans in
                    trans.animation = nil
                }
            Spacer()
            CircleBtnView(iconName: "chevron.down")
//                .onTapGesture {
//                    withAnimation {
//                        self.isShowPortfolio.toggle()
//                    }
//                }
//                .rotationEffect(Angle(degrees: isShowPortfolio ? 180 : 0))
        }
    }
    
    private var titleBar: some View {
        
        HStack {
            Text("Symbol")
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                .frame(width: UIScreen.main.bounds.width/4, alignment: .leading)
            Spacer()
            Text("Information")
                .frame(width: UIScreen.main.bounds.width/4, alignment: .center)
            Spacer()
            Text("Volume")
                .frame(width: UIScreen.main.bounds.width/4, alignment: .trailing)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
            
        }
        .font(.system(size: 14, weight: .bold, design: .rounded))
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
        
    }
    
    private var searchAndButtonView: some View {
        
        HStack (alignment: .center) {
            SearchEquityBarView(theText: $searchText)
            Spacer()
            Button  {
                viewModel.searchWith(text: searchText)
            } label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(
                        searchText.isEmpty ?
                        Color.theme.secondaryText : Color.theme.accent )
                    .frame(width: 50, height: 50) //set btn frame
                    .background(
                        Circle()
                            .foregroundColor(Color.theme.bg)
                    )
                    .shadow(color: Color.theme.accent.opacity(0.55),
                            radius: 10, x: 0, y: 0)
             
            }
            .padding(.horizontal)
            Spacer()

        }
        
    }
    

}



struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StockView()
                .navigationBarHidden(true)
        }
        .environmentObject(DeveloperPreview.initiate.stockViewModel)
    }
}


