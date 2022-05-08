//
//  AppDelegate.swift
//  FaceBookPage
//
//  Created by Владимир on 07.05.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let feedController = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigatorController = UINavigationController(rootViewController: feedController)
        window?.rootViewController = navigatorController
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 51/255, green: 90/255, blue: 149/255, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        // even after setting this the status bar is still black...
        application.statusBarStyle = .lightContent
        // fix is to add the following Info.plist entry
        // `View controller-based status bar` boolean value of `NO`
        
        return true
    }

}
