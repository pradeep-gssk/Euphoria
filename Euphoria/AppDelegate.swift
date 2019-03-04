//
//  AppDelegate.swift
//  Euphoria
//
//  Created by Guduru, Pradeep(AWF) on 2/9/19.
//  Copyright © 2019 Guduru, Pradeep(AWF). All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if !UserDefaults.standard.bool(forKey: IS_PRELOADED) {
            self.preloadData()
            UserDefaults.standard.set(true, forKey: IS_PRELOADED)
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
        self.saveContext()
    }

    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Euphoria")
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
    
    func preloadData() {
        self.loadQuestionnaire(withResource: "Questionnaire1", forIndex: 1, withTotal: 20)
        self.loadQuestionnaire(withResource: "Questionnaire2", forIndex: 2, withTotal: 6)
        self.loadQuestionnaire(withResource: "Questionnaire3", forIndex: 3, withTotal: 35)
        self.loadQuestionnaire(withResource: "Questionnaire4", forIndex: 4, withTotal: 10)
        self.loadQuestionnaire(withResource: "Questionnaire5", forIndex: 5, withTotal: 4)
        self.loadExercises(withResource: "Exercises")
        self.loadSounds(withResource: "Sounds")
        self.loadVideos(withResource: "Videos")
        self.loadDiet(withResource: "Diet")
        
    }
    
    func loadQuestionnaire(withResource resource: String, forIndex index: Int16, withTotal total: Int16) {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [String: AnyObject] {
                    CoreDataHelper.shared.saveQuestionnaire(jsonResult, forIndex: index, withTotal: total)
                }
            } catch {
                // handle error
            }
        }
    }
    
    func loadExercises(withResource resource: String) {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [[String: AnyObject]] {
                    CoreDataHelper.shared.saveExercises(jsonResult)
                }
            } catch {
                print(error)
                // handle error
            }
        }
    }
    
    func loadSounds(withResource resource: String) {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [[String: String]] {
                    CoreDataHelper.shared.saveSound(jsonResult)
                }
            } catch {
                print(error)
                // handle error
            }
        }
    }
    
    func loadVideos(withResource resource: String) {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [[String: AnyObject]] {
                    CoreDataHelper.shared.saveVideos(jsonResult)
                }
            } catch {
                print(error)
                // handle error
            }
        }
    }
    
    func loadDiet(withResource resource: String) {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [[String: AnyObject]] {
                    CoreDataHelper.shared.saveDiet(jsonResult)
                }
            } catch {
                print(error)
                // handle error
            }
        }
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
}
