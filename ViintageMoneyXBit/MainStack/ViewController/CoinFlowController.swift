//
//  CoinVC.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/7.
//

import SwiftUI
import UIKit

class CoinFlowController: UIViewController, ObservableObject {
    
    private var coinViewModel : CoinViewModel!
    
    init(coinVM:CoinViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.coinViewModel = coinVM
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCoinViewToChild()
        navigationController?.navigationBar.isHidden = true
    }
    
    func addCoinViewToChild() {
        
        let controller = UIHostingController(rootView: CoinView()
            .environmentObject(self)
            .environmentObject(coinViewModel)
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
    
    func showCoinPortfolioView() {
        let coinPortfolioView = CoinPortfolioView()
            .environmentObject(self)
            .environmentObject(coinViewModel)
        let viewController = UIHostingController(rootView: coinPortfolioView)
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.present(viewController, animated: true, completion: nil)
    }
    
    func dismissCurrentView() {
        self.navigationController?.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func showCoinDetailView(with detailCoin:Coin) {
        let coinDetailView = CoinDetailView()
            .environmentObject(self)
            .environmentObject(CoinDetailViewModel(coin: detailCoin))
        let hostingVC = UIHostingController(rootView: coinDetailView)
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
    
    
}


