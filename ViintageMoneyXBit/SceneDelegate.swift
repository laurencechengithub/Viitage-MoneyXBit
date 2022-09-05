//
//  SceneDelegate.swift
//  ViintageExchange
//
//  Created by LaurenceMBP2 on 2022/7/6.
//

import UIKit
import SwiftUI

var ENV:APIKEYS {
    #if DEBUG
        return DebugENV()
//        #warning("Mode : debug")
    #else
//        #warning("Mode : prod")
        return ProdENV()
    #endif
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate, ObservableObject, UIGestureRecognizerDelegate {

    var window: UIWindow?
    @Published var displayMode:UIUserInterfaceStyle?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        
        self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        self.window?.windowScene = windowScene
        if #available(iOS 13.0, *) {
            self.window?.overrideUserInterfaceStyle = UIUserInterfaceStyle.dark
        }
        
        self.displayMode = .dark
//        let rootnavi = UINavigationController(rootViewController: LoginVC())
        let rootnavi = UINavigationController(rootViewController: LaunchViewController())
//        rootnavi.navigationBar.barStyle = .black
        rootnavi.navigationBar.isTranslucent = false
        rootnavi.navigationBar.isHidden = true
        window?.rootViewController = rootnavi
        window?.makeKeyAndVisible()
//        addDismissKeypadTapGesture()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func changeThemeMode() {
        
        
        
        print("changeThemeMode")
        if UITraitCollection.current.userInterfaceStyle == .dark {
//            self.window?.overrideUserInterfaceStyle = .light
        } else {
//            self.window?.overrideUserInterfaceStyle = .dark
        }
        
    }
    
    func addDismissKeypadTapGesture() {
        let tapGesture = AnyGestureRecognizer(target: window, action:#selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self //I don't use window as delegate to minimize possible side effects
        window?.addGestureRecognizer(tapGesture)
    }
    
}

