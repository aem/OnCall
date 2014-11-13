//
//  AppDelegate.swift
//  OnCall
//
//  Created by Adam Markon on 10/11/14.
//  Copyright (c) 2014 Marksman Apps. All rights reserved.
//

import UIKit

func showBasicAlert(title: String, #message: String?) {
    let alert = UIAlertView(title: title,
        message: message,
        delegate: nil,
        cancelButtonTitle: "Close")
    alert.show()
}

func validatePhone(phone: String) -> Bool {
    if NSAttributedString(string: phone).length != 10 {
        showBasicAlert("Phone Number Invalid",
            message: "Phone number should be 10 digits long. Please check that " +
            "you entered your number correctly.")
        return false
    } else if phone.toInt() == nil {
        showBasicAlert("Invalid Character(s)",
            message: "One or more of the characters you entered was not a number. " +
            "Please check that you entered your number correctly.")
        return false
    }
    return true
}

func validatePassword(pass: String) -> Bool {
    if NSAttributedString(string: pass).length < 6 {
        showBasicAlert("Password too short",
            message: "Your password should be at least 6 characters. Please " +
            "try again.")
        return false
    }
    return true
}






@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

