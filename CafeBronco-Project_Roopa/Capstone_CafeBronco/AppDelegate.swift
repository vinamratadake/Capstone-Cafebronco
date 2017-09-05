//
//  AppDelegate.swift
//  Capstone_CafeBronco
//
//  Created by Roopa Daga on 5/28/17.
//  Copyright © 2017 SCU. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ESTBeaconManagerDelegate {

    var window: UIWindow?
    
    // 2. Add a property to hold the beacon manager and instantiate it
    let beaconManager = ESTBeaconManager()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        FIRApp.configure()
        
        // 3. Set the beacon manager's delegate
        self.beaconManager.delegate = self
        
        // 4. Authorization request is set to always
        self.beaconManager.requestAlwaysAuthorization()
        
        // 5. To start monitoring using beacons
        self.beaconManager.startMonitoring(for: CLBeaconRegion(proximityUUID:UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, major: 34851, minor: 7108, identifier: "monitored regions"))
        
        // 6. Requesting access to Location Services to use iBeacon features
        UIApplication.shared.registerUserNotificationSettings(
            UIUserNotificationSettings(types: .alert, categories: nil))

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
    //API to integrate beacons in cafebronco app
    
    func beaconManager(_ manager: Any, didEnter region: CLBeaconRegion) {
        let notification = UILocalNotification()
        notification.alertBody =
            " Take away free food between 10:30 - 11:00 PM, only at La Parilla." + " Dont forget to stop by! "
        UIApplication.shared.presentLocalNotificationNow(notification)
    }



}

