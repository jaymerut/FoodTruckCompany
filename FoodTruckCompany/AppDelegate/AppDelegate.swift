//
//  AppDelegate.swift
//  FoodTruckCompany
//
//  Created by Jayme Rutkoski on 9/13/20.
//  Copyright © 2020 foodtruckcompany. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let tabBarHome = UITabBarItem()
        tabBarHome.title = "Home"
        tabBarHome.image = UIImage(named: "home_icon")
        
        let mainVC = HomeViewController()
        //mainVC.tabBarItem = tabBarHome

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainVC]
        tabBarController.tabBar.tintColor = UIColor.init(hex: "0x78d2fa")
        tabBarController.tabBar.barTintColor = UIColor.init(hex: "0x055e86")
        tabBarController.tabBar.isTranslucent = false
        tabBarController.selectedIndex = 0
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont.init(name: "Teko-Medium", size: 16.0)!], for: .normal)
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: -5)
        UITabBar.appearance().unselectedItemTintColor = .white
        
        window!.rootViewController = mainVC
        window!.makeKeyAndVisible()
        
        FirebaseApp.configure()
        
        return true
    }


}

