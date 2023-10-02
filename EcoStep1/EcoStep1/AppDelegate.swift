//
//  AppDelegate.swift
//  EcoStep1
//
//  Created by Федор on 18.12.2021.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications
import GoogleMobileAds
import GoogleSignIn
import FirebaseCore
@main
class AppDelegate: UIResponder, UIApplicationDelegate,MessagingDelegate, UNUserNotificationCenterDelegate  {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
      
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { success, _ in
            guard success else{
                return
            }
            
            print("Success in APNS registry")
            
        }
        
        application.registerForRemoteNotifications()
        
        // Override point for customization after application launch.
        return true
    }
  
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
          
          
      return GIDSignIn.sharedInstance.handle(url)
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, _ in
            guard let token = token else{
                return
            }
            print("Token \(token )")
        }
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
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("opened")
    }

}

