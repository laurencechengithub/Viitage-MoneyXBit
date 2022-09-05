//
//  StockDetailInfoView.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/8/11.
//

import SwiftUI

struct StockDetailInfoView: View {
    
    var infoTitle:String
    var infoValue:String
    var infoPercent:Double?
    
    init(title:String, value:String, percent:Double? = nil) {
        self.infoTitle = title
        self.infoValue = value
        self.infoPercent = percent
    }
    
    var body: some View {
        
        HStack (alignment: .center, spacing: 0) {
            Text(infoTitle)
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .foregroundColor(Color.theme.secondaryText)
            Spacer()
            Text(infoValue)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(Color.theme.accent)
//            if infoPercent != nil {
//                HStack(alignment: .center, spacing: 4) {
//                    let percent = infoPercent ?? 0.0
//                    Image(systemName: "triangle.fill")
//                        .font(.system(size: 12, weight: .bold, design: .rounded))
//                        .rotationEffect(
//                            Angle(
//                                degrees: percent >= 0 ? 0 : 180))
//                    Text(percent.asPercentStringAndRoundTo2())
//                        .font(.system(size: 12, weight: .bold, design: .rounded))
//                }
//            }
        }
    }
}

struct StockDetailInfoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StockDetailInfoView(title: "Title", value: "Vlaue")
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
            
            StockDetailInfoView(title: "Title", value: "Vlaue")
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
        }
        
    }
}
