//
//  StockVC.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/6.
//

import SwiftUI
import UIKit

class StockFlowController: UIViewController, ObservableObject {
    
    private let stockViewModel = StockViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let navi = self.navigationController else { return }
        navi.navigationBar.isHidden = true
 
        addHomeChildView()
    }
    
    func addHomeChildView() {
        
        let controller = UIHostingController(rootView: StockView()
            .environmentObject(self)
            .environmentObject(stockViewModel)
        )
        addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        controller.didMove(toParent: self)

        NSLayoutConstraint.activate([
            controller.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            controller.view.heightAnchor.constraint(equalTo: view.heightAnchor),
            controller.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            controller.view.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    func showStockDetailView(with equity:Equity) {
        
        let stockDetailView = StockDetailView()
            .environmentObject(self)
            .environmentObject(StockDetailViewModel(equity: equity))
        let hostingVC = UIHostingController(rootView: stockDetailView)
        hostingVC.modalPresentationStyle = .fullScreen
        self.navigationController?.present(hostingVC, animated: true)
        
    }
    
    func showSettingView() {
        
        let settingView = SettingView()
            .environmentObject(self)
        let hostingVC = UIHostingController(rootView: settingView)
        hostingVC.modalPresentationStyle = .fullScreen
        self.navigationController?.present(hostingVC, animated: true)
        
    }
    
    func dismissCurrentView() {
        self.navigationController?.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
//    func showPortfolioView() {
//        let portfolioView = PortfolioView()
//            .environmentObject(self)
//            .environmentObject(coinViewModel)
//        let viewController = UIHostingController(rootView: portfolioView)
//        viewController.modalPresentationStyle = .fullScreen
//        self.navigationController?.present(viewController, animated: true, completion: nil)
//    }
    
}
