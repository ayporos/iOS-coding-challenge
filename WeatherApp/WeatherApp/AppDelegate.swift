//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Dmitry on 4/7/18.
//  Copyright © 2018 Dmitry. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let builder = WeatherModuleBuilder()
        let viewController = builder.build()
        window?.rootViewController = viewController
        return true
    }
}

