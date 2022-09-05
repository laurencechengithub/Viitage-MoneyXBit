//
//  SearchBarView.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/12.
//

import SwiftUI

struct SearchBarView: View {
        
    @Binding var searchText:String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.theme.secondaryText : Color.theme.accent )
            TextField("Enter search here", text: $searchText, onCommit: {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            })
                .foregroundColor(Color.theme.accent)
                .disableAutocorrection(true) //鍵盤上邊的自動完成建議字
                .keyboardType(.alphabet)
                .overlay(
                    //右邊小Ｘ
                    Image (systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            searchText = ""
                            UIApplication.shared.endEditing()
                        }
                    ,alignment: .trailing
                )
                
                
        }
        .font(.system(size: 20, weight: .bold, design: .default))
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.bg)
                .shadow(color: Color.theme.accent.opacity(0.35),
                        radius: 10, x: 0, y: 0)
        )
        .padding()
        
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            
            SearchBarView(searchText: .constant(""))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
            
            SearchBarView(searchText: .constant(""))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
            
            
        }
        

            
    }
}
