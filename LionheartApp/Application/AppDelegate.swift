//
//  AppDelegate.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 13.02.21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Main App Window
    
    lazy var window: UIWindow? = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        return window
    }()
    
    // MARK: - App Initialiser
    
    private lazy var appInitialiser: AppInitialiser = {
        guard let window = window else { fatalError(.appWindowFailedToCreate) }
        return AppInitialiser(window: window)
    }()

    // MARK: - App Entry Point
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appInitialiser.initialise(application, launchOptions)
        return true
    }

}

