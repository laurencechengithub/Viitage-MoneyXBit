//
//  LoginVC.swift
//  valuCurityX
//
//  Created by LaurenceMBP2 on 2022/6/25.
//

import Foundation
import UIKit

class LoginVC:UIViewController {
    
    var LoginBtn = ExtentedUIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupView()
    }
    
    func setupView () {
//        view.addSubview(emailInputText)
//        view.addSubview(passwordInputText)
        view.addSubview(LoginBtn)
        
//        emailInputText.translatesAutoresizingMaskIntoConstraints = false
//        passwordInputText.translatesAutoresizingMaskIntoConstraints = false
        LoginBtn.translatesAutoresizingMaskIntoConstraints = false
        LoginBtn.layer.borderColor = UIColor.uiTheme.red?.cgColor
        LoginBtn.layer.borderWidth = 3
        LoginBtn.setTitle("Login", for: .normal)
        LoginBtn.setTitleColor(UIColor.uiTheme.red, for: .normal)
//        LoginBtn.titleLabel?.textAlignment = .
        LoginBtn.layer.cornerRadius = 5
        LoginBtn.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            
            LoginBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            LoginBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 40),
            LoginBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            LoginBtn.heightAnchor.constraint(equalToConstant: 44)
            
        ])
        
    }
    
    @objc func loginBtnTapped() {

        let tabbarView = MasterTabbarController()
        navigationController?.pushViewController(tabbarView, animated: true)
        
    }
    
    
}
