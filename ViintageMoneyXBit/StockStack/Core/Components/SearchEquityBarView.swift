//
//  SearchEquityView.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/8/12.
//

import SwiftUI

struct SearchEquityBarView: View {
    
    @State var startSearch:Bool = false
//    @State var searchString:String = ""
    @Binding var theText:String
    
    var body: some View {
        HStack {
            TextField("Make equity search",
                      text: $theText,
                      onCommit: {
                        self.searchBarReturnTapped(name: theText)
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            })
            .foregroundColor(Color.theme.accent)
            .disableAutocorrection(true) //鍵盤上邊的自動完成建議字
            .keyboardType(.alphabet)
        }
        .padding()
        .font(.system(size: 20, weight: .bold, design: .rounded))
        .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.theme.bg)
                    .shadow(color: Color.theme.accent.opacity(0.35),
                            radius: 10, x: 0, y: 0)
        ).padding()
    }
}

struct SearchEquityView_Previews: PreviewProvider {
    static var previews: some View {
        SearchEquityBarView(theText: .constant(""))
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}


extension SearchEquityBarView {
    
    func searchBarReturnTapped(name: String) {
        print("searchBarReturnTapped: \(name)")
    }
    
    
}
