//
//  AppDelegate.swift
//  MusicPlayer
//
//  Created by Muhammad Affan on 09/03/22.
//

import UIKit
import SnapKit
import netfox

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        createWindow()
        
        NFX.sharedInstance().start()
        window?.rootViewController = MainTabBarController.defaultTabBar
        
        return true
    }

    private func createWindow() {
        let windowFrame = UIScreen.main.bounds
        self.window = UIWindow(frame: windowFrame)
    }
    
}

