//
//  AppDelegate.swift
//  StoreApp
//
//  Created by MAC on 8/27/18.
//  Copyright © 2018 app. All rights reserved.
//

import UIKit
import CoreData
import  UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , UNUserNotificationCenterDelegate {

    var window: UIWindow?

    

    
    var userdeviceToken = "xxxxxxxxxxasmJOncaCMOMOAOMAPA874292$%^%"

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [UNAuthorizationOptions.alert,UNAuthorizationOptions.sound,UNAuthorizationOptions.badge]) { (activitied, error) in
            
        }
        
        UIApplication.shared.registerForRemoteNotifications()
        
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        
        let controller = MainTabBar()
        
       // print(UserDefaults.standard.value(forKey: "profile_image")!)
   //   UserDefaults.standard.set("loggeld", forKey: "logged")
        if let looged = UserDefaults.standard.value(forKey: "logged")  {
            print(looged)
            if looged as! String == "logged" {
                window?.rootViewController = controller
            }else if  looged as! String == "countryandgender" {
                window?.rootViewController = UINavigationController(rootViewController: CountryAndGenderViewController())
            }
            else {
                window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
            }
            
        }else{
            window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        }
        
        
        
        UIApplication.shared.statusBarStyle = .lightContent
//
//        PayPalMobile.initializeWithClientIds(forEnvironments: [PayPalEnvironmentProduction: "AbeK6RGc_QqnuxLd6_3S2xFPca0qZHWmrxfYrNMOt_nbo5lByHxKXDjHQpwWTofUj1ZeJdj8WvuO-P5v", PayPalEnvironmentSandbox: "AbaIkhIHu3TCjz1bsxhqSW3vLsZC-K1Sj_yq721YxCBMjPvM-NJiUwmOJMCaIIdUdCzp_BwjBmvBCurZ"])
//
        
        
        PayPalMobile.initializeWithClientIds(forEnvironments: [PayPalEnvironmentProduction: "AbeK6RGc_QqnuxLd6_3S2xFPca0qZHWmrxfYrNMOt_nbo5lByHxKXDjHQpwWTofUj1ZeJdj8WvuO-P5v", PayPalEnvironmentSandbox: "AbaIkhIHu3TCjz1bsxhqSW3vLsZC-K1Sj_yq721YxCBMjPvM-NJiUwmOJMCaIIdUdCzp_BwjBmvBCurZ"])
       // PayPalMobile.initializeWithClientIds(forEnvironments: [PayPalEnvironmentProduction: "ATPfsL8u5LhzXWblVRpUL0MLPXshrFC8mUtda4DcMxxEMAv61WHzjJpKS2VI37MX0rPq5y2h0hUEK3zT", PayPalEnvironmentSandbox: ""])
        
        return true
    }

   
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }

    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
         print("request for remote no error \(error)")
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        userdeviceToken = token
        
  
        print("request for remote no success  \(token)")
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
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
        let container = NSPersistentContainer(name: "StoreApp")
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

