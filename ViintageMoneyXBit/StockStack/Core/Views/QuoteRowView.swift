//
//  QuoteRowView.swift
//  ViitageEX
//
//  Created by LaurenceMBP2 on 2022/7/4.
//

import SwiftUI

struct QuoteRowView: View {
    
    let quote: Quote
//    let isShowCenter:Bool
    var screenW: CGFloat
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            leftColumn
            Spacer()
//            if isShowCenter {
//                centerColumn
//            }
            centerColumn
            rightColumn
        }
    }
}

struct QuoteRowView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            QuoteRowView(quote: devPreview.fakeQuote, screenW: UIScreen.main.bounds.width)
                .previewLayout(.sizeThatFits)
            
            QuoteRowView(quote: devPreview.fakeQuote, screenW: UIScreen.main.bounds.width)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        
    }
}


extension QuoteRowView {
    
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text(quote.globalQuote.the01Symbol)
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .bold()
                .padding(.leading, 6)
                .frame(width: screenW/5, height: 45, alignment: .leading)
                .foregroundColor(Color.theme.accent)
                .scaledToFit()
                .minimumScaleFactor(0.01)
                .lineLimit(1)
            Text(quote.globalQuote.the05Price.toDouble().asDoubleString(roundTo: 2))
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
                .frame(alignment: .leading)
                .scaledToFit()
                .minimumScaleFactor(0.01)
                .lineLimit(1)
            
            Text(quote.globalQuote.the09Change.toDouble().asDoubleString(roundTo: 2))
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(
                    quote.globalQuote.the09Change.toDouble() >= 0.0 ? Color.theme.green : Color.theme.red
                )
                .scaledToFit()
                .minimumScaleFactor(0.01)
                .lineLimit(1)
//                .frame(width: screenW/5, height: 35, alignment: .center)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 20, style: .continuous)
//                        .stroke(Color.theme.green, lineWidth: 3)
//                )
                .padding(.leading,16)
        }
  
    }
    
    private var centerColumn: some View {
        
        VStack(alignment: .trailing, spacing: 0) {
            Text("Open")
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
                .scaledToFit()
                .minimumScaleFactor(0.01)
                .lineLimit(1)
//                .frame(width: screenW/5,alignment: .trailing)
            Text("$ "+"\(quote.globalQuote.the02Open.toDouble().asDoubleString(roundTo: 2))")
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
                .scaledToFit()
                .minimumScaleFactor(0.01)
                .lineLimit(1)
//                .frame(width: screenW/5, alignment: .trailing)
                
        }
        
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing, spacing: 0) {
            Text("Volume")
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                .scaledToFit()
                .minimumScaleFactor(0.01)
                .lineLimit(1)
//                .frame(width: screenW/5,alignment: .trailing)
            Text(quote.globalQuote.the06Volume)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                .scaledToFit()
                .minimumScaleFactor(0.01)
                .lineLimit(1)
//                .frame(width: screenW/5,alignment: .trailing)
        }
        //make sure 最右邊方塊 的leading不會跑版
        .frame(width: UIScreen.main.bounds.width / 5, alignment: .trailing)
    }
    
    
    
}
