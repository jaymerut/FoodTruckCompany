//
//  AppDelegate.swift
//  FoodTruckCompany
//
//  Created by Jayme Rutkoski on 9/13/20.
//  Copyright © 2020 foodtruckcompany. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window!.rootViewController = ViewController()
        window!.makeKeyAndVisible()
        return true
    }


}

