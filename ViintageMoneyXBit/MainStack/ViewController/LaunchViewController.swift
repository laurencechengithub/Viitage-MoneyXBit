//
//  LaunchViewController.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/8/4.
//

import Foundation
import UIKit

class LaunchViewController:UIViewController {

    private var logoImageView = UIImageView()
    private var progressView = UIProgressView(progressViewStyle: .bar)
    
    override func viewDidLoad() {
        super .viewDidLoad()
        view.backgroundColor = UIColor.init(red: 12, green: 11, blue: 11, alpha: 0)
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    deinit {
        print("LaunchViewController deinit")
    }
    
    func setupView() {
        
        self.view.addSubview(logoImageView)
        self.view.addSubview(progressView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        let img = UIImage(named: "Logo")
        logoImageView.image = img
        logoImageView.contentMode = .scaleToFill
        progressView.setProgress(0.95, animated: true)
        progressView.tintColor = UIColor.uiTheme.red
     
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 120),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 70),
            progressView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            progressView.heightAnchor.constraint(equalToConstant: 5),
            progressView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.7)
            
        ])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3 ) {
            self.progressView.progress = 1.0
            if self.progressView.progress == 1.0 {
                self.pushToMasterTabController()
            }
            
        }
        
    }
    
    func pushToLogin() {
        
        let loginVC = LoginVC()
        loginVC.modalPresentationStyle = .fullScreen
        loginVC.modalTransitionStyle = .flipHorizontal
        if let navi = self.navigationController {
            navi.pushViewController(loginVC, animated: false)
        }
    }
    
    func pushToMasterTabController() {
            
        let tabbarView = MasterTabbarController()
        if let navi = self.navigationController {
            navi.pushViewController(tabbarView, animated: false)
        }
        
    }
    
    
}


//@propertyWrapper struct autoResize {
//    var wrappedValue: UIView {
//        didSet { wrappedValue = wrappedValue.translatesAutoresizingMaskIntoConstraints = false }
//    }
//
//    init(wrappedValue: UIView) {
//        self.wrappedValue = wrappedValue.translatesAutoresizingMaskIntoConstraints = false
//    }
//}
