//
//  AppDelegate.swift
//  FoodTruckCompany
//
//  Created by Jayme Rutkoski on 9/13/20.
//  Copyright © 2020 foodtruckcompany. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        /*
        let tabBarHome = UITabBarItem()
        tabBarHome.title = "Home"
        tabBarHome.image = UIImage(named: "home_icon")
        */
        let customFont = UIFont(name: "Teko-Medium", size: 20.0)!
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: customFont], for: .normal)
        let mainVC = HomeViewController()
        //mainVC.tabBarItem = tabBarHome
        let destinationNC = UINavigationController(rootViewController: mainVC)
        destinationNC.navigationBar.barTintColor = Constants.mainColor
        destinationNC.navigationBar.tintColor = .white
        destinationNC.navigationBar.isTranslucent = false
/*
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainVC]
        tabBarController.tabBar.tintColor = UIColor.init(hex: "0x78d2fa")
        tabBarController.tabBar.barTintColor = Constants.mainColor
        tabBarController.tabBar.isTranslucent = false
        tabBarController.selectedIndex = 0
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont.init(name: "Teko-Medium", size: 16.0)!], for: .normal)
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset.init(horizontal: 0, vertical: -5)
        UITabBar.appearance().unselectedItemTintColor = .white
        */
        window!.rootViewController = destinationNC
        window!.makeKeyAndVisible()
        
        FirebaseApp.configure()
        
        // Initialize the Google Mobile Ads SDK.
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        return true
    }


}

