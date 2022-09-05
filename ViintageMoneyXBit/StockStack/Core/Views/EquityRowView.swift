//
//  EquityView.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/8/10.
//

import SwiftUI

struct EquityRowView: View {
    
    @State var isPinned:Bool = false
    var equity:Equity
    
    
    init(equity:Equity) {
        self.equity = equity
    }
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 10) {
            Text(equity.the1Symbol)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .frame(width: 120, alignment: .leading)
                .foregroundColor(Color.theme.secondaryText)
                .lineLimit(1)
//            Spacer()
//            Text(equity.the2Name)

//                .font(.system(size: 12, weight: .medium, design: .rounded))
//                .foregroundColor(Color.theme.secondaryText)
            Spacer()
            VStack (alignment:.trailing) {
                Text(equity.the4Region)
                    .font(.system(size: 8, weight: .medium, design: .rounded))
                    .foregroundColor(Color.theme.secondaryText)
                    .frame(width: 80, alignment: .trailing)
                Text(equity.the8Currency)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(Color.theme.accent)
            }
//            Button {
//                self.isPinned = true
//            } label: {
//                if isPinned == true {
//                    Image(systemName: "pin.fill")
//                } else {
//                    Image(systemName: "pin")
//                }
//
//            }

        }
        .padding()
        
    }
}

struct EquityView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EquityRowView(equity: devPreview.fakeEquityOne)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
        
        
    }
}
