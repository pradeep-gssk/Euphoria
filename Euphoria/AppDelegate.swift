//
//  AppDelegate.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 5/5/18.
//  Copyright © 2018 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var sessions: [EUSession] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        if let decoded = UserDefaults.standard.object(forKey: SESSIONS) as? Data,
            let items = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? [EUSession] {
            self.sessions = items
        }
        
        guard let _ = UserDefaults.standard.object(forKey: USER_PROFILE_DATA) else {
            self.showLoginView()
            return true
        }
        
        
        
        
        self.showHomeView()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme!.hasPrefix("fb") {
            return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        }
        
        return true
    }
    
    func showLoginView()  {
        guard UserDefaults.standard.bool(forKey: I_AGREE) else {
            self.window?.rootViewController = EUConcentViewController.loadConcentView()
            return
        }
        
        let loginStoryboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let navigationController = loginStoryboard.instantiateInitialViewController()
        self.window?.rootViewController = navigationController
    }
    
    func showHomeView(){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = mainStoryboard.instantiateInitialViewController()
        self.window?.rootViewController = navigationController
    }
    
//    func encode(_ session: EUSession)  {
//        self.sessions.append(session)
//        let encodedData = NSKeyedArchiver.archivedData(withRootObject: self.sessions)
//        UserDefaults.standard.set(encodedData, forKey: SESSIONS)
//
//    }
}

