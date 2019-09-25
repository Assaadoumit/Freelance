//
//  AppDelegate.swift
//  Free
//
//  Created by MacBookPro on 6/21/19.
//  Copyright © 2019 MacBookPro. All rights reserved.
//

import UIKit
import Firebase
//import FacebookCore
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //"AllIndustriesViewController")  SignUpViewController

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        
        let isVerified :Bool = UserDefaults.standard.bool(forKey: "isVerified")
        if isVerified == true{
            let vc = MyProfileViewController()
            UserDefaults.standard.set(true, forKey: "isVerified")
            print("is Verified ")
        }else{
            UserDefaults.standard.set(false, forKey: "isVerified")
        }

        let isUserLoggedIn:Bool = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
    
        if(isUserLoggedIn == false) {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            // create view controllers from storyboard
            // Interface Builder -> Identitiy Inspector -> Storyboard ID
            // Set up the Tab Bar Controller to have two tabs
            let viewController  = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
            
            
            
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()
            
        }else {
            print("is logged in")
            let vc = SignUpPhoneNumberViewController()
            if vc.phoneNumberTextField != nil {
                print("\(String(describing: vc.phoneNumberTextField)) signed in")
            }else{
                print("phone number not avialble")
            }
        let vc1 = SignUpViewController()
            if vc1.emailTextField != nil {
                print("\(String(describing: vc1.emailTextField)) signed in")
            }else{
                print("email not availble")
            }
        }
        
            return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return ApplicationDelegate.shared.application(application, open: url, sourceApplication: sourceApplication , annotation : annotation)
    }
    
    
    //"AllIndustriesViewController"
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

