//
//  StockDetailView.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/8/10.
//

import SwiftUI

struct StockDetailView: View {
    
    @EnvironmentObject var viewModel:StockDetailViewModel
    @EnvironmentObject var stockFlowController:StockFlowController
    
    let gridLayout:[GridItem] = [GridItem(.adaptive(minimum: 100),spacing: 16)]
    @State private var chartViewTrimValue:Double = 0

    init() {
    }
    
    var body: some View {
        
        ZStack {
            VStack (alignment: .leading, spacing: 10) {
                NaviTitleView.padding()
                Spacer()
                HStack {
                    Text("past 7d")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(Color.theme.accent)
                        .padding(EdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6))
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.theme.accent, lineWidth: 2)
                        )
                }
                .padding(.horizontal)
                infoPartOne
                Spacer()
                stokChartView
                    .padding()
                    .background(
                    ZStack (alignment: .topLeading) {
                        VStack{
                            Divider()
                            Spacer()
                            Divider()
                            Spacer()
                            Divider()
                        }
                        .zIndex(0)
                        .padding(.horizontal)
                        
                        VStack {
                            Text("\(viewModel.openHistory.max() ?? 0.0)")
                                .foregroundColor(Color.theme.secondaryText)
                                .font(.system(size: 10, weight: .bold, design: .rounded))
                            Spacer()
                            Text("\(viewModel.openHistory.min() ?? 0.0)")
                                .foregroundColor(Color.theme.secondaryText)
                                .font(.system(size: 10, weight: .bold, design: .rounded))
                        }
                        .zIndex(1)
                        .padding(.horizontal)
                    }
                )
    
                Spacer()
  
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation (.linear(duration: 1)) {
                        self.chartViewTrimValue = 1.0
                    }
                }
            }
//            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        }
    }
}

struct StockDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StockDetailView()
            .environmentObject(devPreview.stockdetailViewModel)
            .preferredColorScheme(.dark)
    }
}


extension StockDetailView {
    
    private var NaviTitleView: some View {
        
        HStack {
            Text("\(viewModel.equityName)")
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundColor(Color.theme.accent)
            Spacer()
            Button {
                dismissBtnTapped()
            } label: {
                Image(systemName: "xmark")
            }
        }
        
    }
    
    private var infoPartOne :some View {

   
        List  {
            StockDetailInfoView(title: "Symbol",
                                value: viewModel.equity.the1Symbol)
            StockDetailInfoView(title: "Region",
                                value: viewModel.equity.the4Region)
            StockDetailInfoView(title: "Currency",
                                value: viewModel.equity.the8Currency)
            if let quote = viewModel.quote {
                StockDetailInfoView(title: "Price",
                                    value: quote.globalQuote.the05Price)
                StockDetailInfoView(title: "Change",
                                    value: quote.globalQuote.the09Change,
                                    percent: Double(quote.globalQuote.the10ChangePercent) ?? 0.0 )
            }
        }
//        LazyVGrid (columns: gridLayout,
//                   alignment: .center,
//                   spacing: 10,
//                   pinnedViews: []) {
//
//
//        }
    }
    
    private var stokChartView :some View {
        
        GeometryReader { geometry in

            Path { path in
                let data = viewModel.openHistory
                let dataMaxY = data.max() ?? 0.0
                let dataMinY = data.min() ?? 0.0
                let widthInBetweenXaxisCoordinates = geometry.size.width / CGFloat(data.count)
    
                let hightInBetweenYaxisMaxYToMinY:Double = dataMaxY - dataMinY
                
                for index in data.indices {
                    
                    let xPosition = CGFloat(index + 1) * widthInBetweenXaxisCoordinates
                    let yRatio = (data[index] - dataMinY) / hightInBetweenYaxisMaxYToMinY
                    let yPosition = (1 - yRatio) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                        //iphone coordinates (0,0) 在最左上
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: chartViewTrimValue)
            .stroke(Color.theme.red, lineWidth: 2.0)
            .shadow(color: Color.theme.red.opacity(0.6), radius: 10, x: 0, y: 10)
            .shadow(color: Color.theme.red.opacity(0.5), radius: 10, x: 0, y: 20)
            .shadow(color: Color.theme.red.opacity(0.3), radius: 10, x: 0, y: 30)
            .shadow(color: Color.theme.red.opacity(0.1), radius: 10, x: 0, y: 40)
        }
        
    }
    
    
}

extension StockDetailView {
    
    func dismissBtnTapped() {
        self.stockFlowController.dismissCurrentView()
    }
}
