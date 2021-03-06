//
//  AppDelegate.swift
//  Pet donate
//
//  Created by Виктория on 28.11.2019.
//  Copyright © 2019 Виктория. All rights reserved.
//

import UIKit
import GoogleSignIn
import SwiftyBeaver
let log = SwiftyBeaver.self

@UIApplicationMain

//google authorization performing
class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate {
func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {

      if let error = error {
        if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
          print("The user has not signed in before or they have since signed out.")
        } else {
          print("\(error.localizedDescription)")
        }
        return
      }
     
      let userId = user.userID                  // For client-side use only!
      let idToken = user.authentication.idToken // Safe to send to the server
      let fullName = user.profile.name
      let givenName = user.profile.givenName
      let familyName = user.profile.familyName
      let email = user.profile.email
    
    UserDefaults.standard.set(userId, forKey: "ID")
    UserDefaults.standard.set(userId, forKey: "token")
    UserDefaults.standard.set(email, forKey: "userEmail")
    UserDefaults.standard.set(fullName, forKey: "userName")

}

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GIDSignIn.sharedInstance().clientID = "332998443542-fcpph3qc7h303bndqel86d8q0glc58na.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
        let console = ConsoleDestination()
        log.addDestination(console)
        log.info("The launch of app")
        
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
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        
        print ("sign out")
    }


}

