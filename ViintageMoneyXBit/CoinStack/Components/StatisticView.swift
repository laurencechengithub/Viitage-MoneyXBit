//
//  StatisticView.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/15.
//

import SwiftUI

struct StatisticView: View {
    
    let statistic:Statistic
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 4) {
                Text(statistic.title)
                    .foregroundColor(Color.theme.secondaryText)
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                Text(statistic.value)
                    .foregroundColor(Color.theme.accent)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                bottomViews
            }
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {

            StatisticView(
                statistic: self.devPreview.fakeStatisticOne
//                statisticTwo: self.devPreview.fakeStatisticTwo
                )
            .preferredColorScheme(.light)
            .previewLayout(.sizeThatFits)
            
            
            StatisticView(
                statistic: self.devPreview.fakeStatisticOne
//                statisticTwo: self.devPreview.fakeStatisticTwo
                )
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
        }
        
  
    }
}


extension StatisticView {
    
    private var bottomViews: some View {
        
        HStack(alignment: .center, spacing: 4) {
            Image(systemName: "triangle.fill")
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .rotationEffect(
                    Angle(
                        degrees: (statistic.percentageChange ?? 0.0) >= 0 ? 0 : 180))
            Text(statistic.percentageChange?.asPercentStringAndRoundTo2() ?? "")
                .font(.system(size: 12, weight: .bold, design: .rounded))
        }
        .foregroundColor(
            (statistic.percentageChange ?? 0.0) >= 0 ? Color.theme.green : Color.theme.red)
        .opacity(statistic.percentageChange == nil ? 0.0 : 1.0)
        
    }
}

    

