//
//  CoinChartView.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/28.
//

import SwiftUI

struct CoinChartView: View {
    
    private var data:[Double]
    private var coinMaxY:Double
    private var coinMinY:Double
//    private var lineColor = Color.theme.red
//    private var upOrDown:Double
    private let startDate:Date
    private let endingDate:Date
    @State private var chartViewTrimValue:Double = 0
    
    init(coin:Coin) {
        self.data = coin.sparklineIn7D?.price ?? []
        self.coinMaxY = data.max() ?? 0.0
        self.coinMinY = data.min() ?? 0.0
        self.startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        self.endingDate = Date(viintageEXString: coin.lastUpdated ?? "")
        
    }
    
    //假設
    //總寬300
    //100筆資料
    //每筆資料間隔 300/100 = 3
    //n=1, x 座標 : 1 * 3 = 3
    //n=2, x 座標 : 2 * 3 = 6
    //n=100, x 座標 : 100 * 3 = 300
    
    //Ｙ座標 就是某筆資料 價錢
    //假設
    //最高價錢 6000
    //最低價錢 5000
    //100筆資料 座落在 6000 - 5000 = 1000 這區間
    //Y座標就介於 0 ~ 1000
    
    //某筆資料 eg:5400
    //將該筆價錢 - 最低價錢 / 1000
    //某筆資料Y座標所在相對高度 => ( 5400 - 5000 ) / ( 6000 - 5000 ) = 0.4 => 相對於0位址向上40%
    
    //真正Ｙ座標
    //某筆資料Y座標所在相對高度百分比 * 圖的總體高度
    
    
    var body: some View {
        
        VStack {
            chartView
                .frame(height: 200, alignment: .center)
            dateViewUnderChart
        }
        .font(.system(size: 14, weight: .bold, design: .rounded))
        .onAppear {
            //when Vstack shows we gonna delay by 0.5 sec
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation (.linear(duration: 2)) {
                    chartViewTrimValue = 1.0
                }
            }
        }

        
        
    }
}

struct CoinChartView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            CoinChartView(coin: devPreview.fakeCoin)
                .preferredColorScheme(.dark)
            
            CoinChartView(coin: devPreview.fakeCoin)
                .preferredColorScheme(.light)
            
        }
    }
}

extension CoinChartView {
    
    private var chartView : some View {
        
        //if not inside GeometryReader, than we could not put it into customized frames
        GeometryReader  { Geometry in
            
            Path { path in
//                let widthInBetweenXaxisCoordinates = UIScreen.main.bounds.width / CGFloat(data.count)
                let widthInBetweenXaxisCoordinates = Geometry.size.width / CGFloat(data.count)

                let hightInBetweenYaxisFromMaxYToMinY = coinMaxY - coinMinY
                
                for index in data.indices {
                    //每個index的 xPosition = n * widthBetweenOneCoordinate
                    let xPosition = CGFloat(index + 1) * widthInBetweenXaxisCoordinates
                    
                    //yPosition
                    let indexYaxisRatio = ((data[index] - coinMinY) /  hightInBetweenYaxisFromMaxYToMinY)
                    let yPosition = (1 - indexYaxisRatio) * Geometry.size.height
                    
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
            .background(
                coinChartViewBackGround
            )
        }
    }
    
    
    private var coinChartViewBackGround : some View {
        
        ZStack (alignment: .topLeading) {
            VStack{
                Divider()
                Spacer()
                Divider()
                Spacer()
                Divider()
            }.zIndex(0)
            VStack {
                Text(self.coinMaxY.formattedWithAbbreviations())
                    .foregroundColor(Color.theme.secondaryText)
                Spacer()
                Text(self.coinMinY.formattedWithAbbreviations())
                    .foregroundColor(Color.theme.secondaryText)
            }.zIndex(1)
        }
        
    }
    
    private var dateViewUnderChart : some View {
        HStack {
            Text(self.startDate.toShortFormatDateString())
                .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
                .foregroundColor(Color.theme.secondaryText)
            Spacer()
            Text(self.endingDate.toShortFormatDateString())
                .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
                .foregroundColor(Color.theme.secondaryText)
        }
    }
    
    
}


