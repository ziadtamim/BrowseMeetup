//
//  AppDelegate.swift
//  BrowseMeetup
//
//  Created by Ziad on 10/13/16.
//  Copyright © 2016 Intensify Studio. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window                      = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor          = UIColor.white
        
        let feedVC  = MeetupFeedViewController()
        let feedNavCtrl = UINavigationController(rootViewController: feedVC)
        window.rootViewController  = feedNavCtrl
        
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}

