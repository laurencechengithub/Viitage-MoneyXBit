//
//  MasterTabbarController.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/6.
//

import UIKit
import SwiftUI

class MasterTabbarController: UITabBarController, ObservableObject {

    private let coinViewModel = CoinViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = .systemGreen
        UITabBar.appearance().backgroundColor = UIColor.systemBackground.withAlphaComponent(0.5)
        viewControllers = [createCoinNavigationControl(),createStockNavigationControl()]
    }
    

    func createStockNavigationControl() -> UINavigationController {
        let stockVC = StockFlowController()
        let sfStockImg = UIImage(systemName: "chart.line.uptrend.xyaxis")
//        stockVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0 )
        stockVC.tabBarItem = UITabBarItem(title: "Stock", image: sfStockImg, tag: 0)
        
        return UINavigationController(rootViewController: stockVC)
    }
    
    func createCoinNavigationControl() -> UINavigationController {

//         //For not using the UINavigation
//        let coinView = CoinView()
//            .environmentObject(self)
//        let hostVC = UIHostingController(rootView: coinView)
//        let sfCoinImg = UIImage(systemName: "bitcoinsign.circle")
//        hostVC.tabBarItem = UITabBarItem(title: "Coin", image: sfCoinImg, tag: 1)
        
        let coinVC = CoinFlowController(coinVM: coinViewModel)
        let sfCoinImg = UIImage(systemName: "bitcoinsign.circle")
//        coinVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        coinVC.tabBarItem = UITabBarItem(title: "Coin", image: sfCoinImg, tag: 1)

        return UINavigationController(rootViewController: coinVC)
    }

//    func createSettingNavigationController() -> UINavigationController {
//
//        let settingView = SettingView()
//            .environmentObject(self)
//        let hostingVC = UIHostingController(rootView: settingView)
//        let settingImg = UIImage(systemName: "gearshape")
//        hostingVC.tabBarItem = UITabBarItem(title: "Setting", image: settingImg, tag: 2)
//
//        return UINavigationController(rootViewController: hostingVC)
//
//    }
    
}
