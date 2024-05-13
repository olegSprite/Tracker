//
//  AppDelegate.swift
//  Tracker
//
//  Created by Олег Спиридонов on 04.04.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        var window: UIWindow?
        window = UIWindow()
        if UserDefaults.standard.string(forKey: "onboardingIsCompleted") != nil {
            window?.rootViewController = TabBarViewController()
        } else {
            window?.rootViewController = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        }
        window?.makeKeyAndVisible()
        DaysValueTransformer.register()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}

}

