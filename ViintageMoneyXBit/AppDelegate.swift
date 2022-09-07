//
//  AppDelegate.swift
//  ViintageMoneyXBit
//
//  Created by LaurenceMBP2 on 2022/9/5.
//

import UIKit
import CoreData
import Firebase
import FirebaseMessaging
import UserNotifications


@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Google FCM
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert,.sound,.badge]) { success, error in
                guard success else {
                    return
                }
                print("APNS register succesul")
        }
        
        //The notification closure is not run on the main thread
        DispatchQueue.main.async {
            application.registerForRemoteNotifications()
        }
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ViintageMoneyXBit")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

//Push Notification
extension AppDelegate {
    
    func messaging(_ messaging: Messaging,
                   didReceiveRegistrationToken fcmToken: String?) {
        
        guard let token = fcmToken else {
            return
        }
        
        print("messaging : \(messaging)")
        print("fcmToken : \(token)")
    }
    
    
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                didReceive response: UNNotificationResponse) async {
//
//        let userInfo = response.notification.request.content.userInfo
//        print("userInfo : \(userInfo)")
//    }
    
    //when app is at background
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
    
        let userInfo = response.notification.request.content.userInfo
           // Print message ID.
        
        
        let aps = userInfo["aps"] as? [String: Any]
        let alert = aps?["alert"] as? [String: String]
        let title = alert?["title"]
        let body = alert?["body"]
        
        
        print(title ?? "title is nil")
        print(body ?? "body is nil")
        print(aps ?? "aps is nil")
        print("###FCM notification didReceive###")
        print("userInfo : \(userInfo)")
        
        /*
        userInfo : [AnyHashable("gcm.n.e"): 1, AnyHashable("aps"): {
            alert =     {
                body = "another test";
                title = Viintage;
            };
            "mutable-content" = 1;
        }, AnyHashable("google.c.a.e"): 1, AnyHashable("google.c.fid"): eihBqudh8EQgn06_a2W4Dn, AnyHashable("google.c.sender.id"): 440648821266, AnyHashable("google.c.a.c_id"): 7796953745001234594, AnyHashable("google.c.a.udt"): 0, AnyHashable("google.c.a.c_l"): Viintage, AnyHashable("gcm.message_id"): 1662451782639869, AnyHashable("google.c.a.ts"): 1662451782]
        */
    
        
        completionHandler()
    }
    
    //when app is at foregrand
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print("Here")
        
    }
        
    
    
    
}


