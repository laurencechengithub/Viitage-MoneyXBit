//
//  XMarkBtn.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/20.
//

import SwiftUI

struct XMarkBtn: View {
    
    @Environment(\.presentationMode) var presentationMode
     
     var body: some View {
         Button(action: {
             presentationMode.wrappedValue.dismiss()
         }, label: {
             Image(systemName: "xmark")
                 .font(.headline)
         })
     }
}

struct XMarkBtn_Previews: PreviewProvider {
    static var previews: some View {
        XMarkBtn()
    }
}
