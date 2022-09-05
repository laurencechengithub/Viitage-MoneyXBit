//
//  SettingView.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/8/3.
//

import SwiftUI

struct SettingView: View {
    
    @EnvironmentObject var coinFlowController : CoinFlowController
    @EnvironmentObject var scene : SceneDelegate
    
    let coingecoURL = URL(string: "https://www.coingecko.com/")!
    let developerURL = URL(string: "https://www.linkedin.com/in/laurence-chen-59435b88/")!
    
    @State private var userModeIsDark = true
    
    
    var body: some View {
        VStack {
            naviTitleView.padding(.horizontal)
            List {
                viitangeSection
                coingeckoSection
                developerSection
                applicationSection
            }
            .listStyle(.grouped)
        }

    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        
        SettingView()
            .preferredColorScheme(.dark)
                
        SettingView()
            .preferredColorScheme(.light)
        
    }
}


extension SettingView {
    
    private var naviTitleView: some View {
        
        HStack {
            Text("Setting")
                .font(.system(size: 52, weight: .bold, design: .rounded))
                .foregroundColor(Color.theme.accent)
                .minimumScaleFactor(0.8)
            Spacer()
            Button {
                crossBtnTapped()
            } label: {
                Image(systemName: "xmark")
            }
        }
        
    }
    
    private func crossBtnTapped() {
        coinFlowController.dismissCurrentView()
    }
    
    
    private var viitangeSection : some View {
        Section(header: Text("Viitage EX")) {
            VStack (alignment:.leading,spacing:5) {
                Image("Logo")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Text("Special Thanks To :").fontWeight(.bold)
                Text("@SwiftfulThinking, where this app took reference from.")
                    .lineLimit(nil)
                    .font(.system(size: 13, weight: .light, design: .rounded))
            }.padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        }
    }
    
    private var coingeckoSection : some View {
        Section(header: Text("Coin Gecko")) {
            VStack (alignment:.leading,spacing: 5) {
                Image("coinGecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Text("Special Thanks To :").fontWeight(.bold)
                Text("Coingecko, where this app utilize their reliable coin data and api")
                    .lineLimit(nil)
                    .font(.system(size: 13, weight: .light, design: .rounded))
            }.padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        }
    }
    
    private var developerSection : some View {
        
        Section (header: Text("Developer")) {
            VStack (alignment:.leading,spacing: 5) {
                Image("L2g2Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Text("This app was developed by Laurence Chen").fontWeight(.bold)
                Link("Visit LinkedIn", destination: developerURL)
            }
        }
        
    }
    
    func changeMode() {
        
        if UITraitCollection.current.userInterfaceStyle == .dark {

            
            
        } else {
            
        }
        
    }
    
    
    private var applicationSection : some View {
        
        Section (header: Text("Application")) {
            
            VStack {
//                Toggle(isOn: $userModeIsDark) {
//                    Text("DarkMode")
//                }
                Toggle("DarkMode", isOn: $userModeIsDark)
                    .onChange(of: userModeIsDark, perform: { newValue in
                        if newValue == true {
                            scene.changeThemeMode()
                        } else {
                            print("false")
                            scene.changeThemeMode()
                        }
                    })
                .toggleStyle(SwitchToggleStyle(tint: Color.theme.red))
                
                
                
            }
        }

    }
    
}
