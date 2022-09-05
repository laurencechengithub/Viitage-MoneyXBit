//
//  CircleBtnAnimationView.swift
//  ViitageEX
//
//  Created by LaurenceMBP2 on 2022/6/30.
//

import SwiftUI

struct CircleBtnAnimationViewEffect: View {
    
    @Binding var isAnimate:Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(isAnimate ? 1.0 : 0.0)
            .opacity(isAnimate ? 0.0 : 1.0)
            .animation( isAnimate ? Animation.easeOut(duration: 1.0) : .none , value: isAnimate)
    }
}

struct CircleBtnAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CircleBtnAnimationViewEffect(isAnimate: .constant(false))
            .previewLayout(.sizeThatFits)
            .frame(width: 100, height: 100)
    }
}
