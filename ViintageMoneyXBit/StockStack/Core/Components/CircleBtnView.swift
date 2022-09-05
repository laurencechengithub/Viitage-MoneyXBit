//
//  CircleBtnView.swift
//  ViitageEX
//
//  Created by LaurenceMBP2 on 2022/6/30.
//

import SwiftUI

struct CircleBtnView: View {
    
    let iconName : String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline) //changing the size
            .foregroundColor(Color.theme.accent) //font color
            .frame(width: 50, height: 50, alignment: .center) //set btn frame
            .background(
                Circle()
                    .foregroundColor(Color.theme.bg)
            )
            .shadow(color: Color.theme.accent.opacity(0.55),
                    radius: 10, x: 0, y: 0)
            .padding()
    }
}

struct CircleBtnView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleBtnView(iconName: "info")
                .previewLayout(.sizeThatFits)
            
            CircleBtnView(iconName: "plus")
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
