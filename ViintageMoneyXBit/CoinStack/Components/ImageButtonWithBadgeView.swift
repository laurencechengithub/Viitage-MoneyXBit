//
//  ImageButtonWithBadgeView.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/20.
//

import SwiftUI

struct ImageButtonWithBadgeView: View {
    
//    @State var labelNumber = 1

    var body: some View {
        ZStack {
            if #available(iOS 15.0, *) {
                Image(systemName: "tray.and.arrow.down")
                    .font(.system(size: 40, weight: .bold, design: .rounded )) //changing the size
                    .foregroundColor(Color.theme.accent) //font color
                //                .frame(width: 60, height: 60, alignment: .center) //set btn frame
                    .overlay(alignment: .topTrailing, content: {
                        Capsule()
                            .fill(Color.green)
                            .frame(width: 25, height: 25, alignment: .topTrailing)
                            .position(x: 50, y: 0)
                        Text("v")
                            .foregroundColor(Color.white)
                            .font(Font.system(size: 20).bold()).position(CGPoint(x: 50, y: 0))
                    })
                    .padding()
            } else {
                Image(systemName: "tray.and.arrow.down")
                    .font(.system(size: 40, weight: .bold, design: .rounded )) //changing the size
                    .foregroundColor(Color.theme.accent) //font color
                    .overlay(
                        Capsule()
                            .fill(Color.green)
                            .frame(width: 25, height: 25, alignment: .topTrailing)
                            .position(x: 50, y: 0)
                            .overlay(
                                //Text("\(labelNumber)")
                                Text("v")
                                    .foregroundColor(Color.white)
                                    .font(Font.system(size: 20).bold()).position(CGPoint(x: 50, y: 0)))
                    )
                    .padding()
            }
        }
        .ignoresSafeArea()


    }
}

struct ImageButtonWithBadgeView_Previews: PreviewProvider {
    static var previews: some View {
        ImageButtonWithBadgeView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}



