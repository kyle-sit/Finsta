//
//  AppDelegate.swift
//  Finsta
//
//  Created by Kyle Sit on 3/11/17.
//  Copyright © 2017 Kyle Sit. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Connect to our Parse database
        Parse.initialize(with: ParseClientConfiguration(block: { (configuration: ParseMutableClientConfiguration) in
            configuration.applicationId = "finsta"
            configuration.server = "https://finstaa.herokuapp.com/parse"
        }))
        
        //Persist user
        if PFUser.current() != nil {
            let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "HomePage") as UIViewController
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
            return true
        }
        
        /*window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //Set up tab bar for photo feed
        let homeFeedNavController = storyboard.instantiateViewController(withIdentifier: "HomePageNavigationController") as! UINavigationController
        homeFeedNavController.tabBarItem.title = "Photo Feed"
        homeFeedNavController.tabBarItem.image = UIImage(named: "photoFeed")
        
        //set up tab bar for taking a photo
        let takePhotoNavController = storyboard.instantiateViewController(withIdentifier: "HomePageNavigationController") as! UINavigationController
        takePhotoNavController.tabBarItem.title = "Take Photo"
        takePhotoNavController.tabBarItem.image = UIImage(named: "takePhoto")
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeFeedNavController, takePhotoNavController]
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()*/
        
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


}

