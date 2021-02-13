//
//  AppInitialiser.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 13.02.21.
//

import UIKit

final class AppInitialiser {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func initialise(_ app: UIApplication, _ options: [UIApplication.LaunchOptionsKey: Any]?) {
        setupThirdPartyLibraries(app, options)
    }
    
}

private extension AppInitialiser {
    func setupThirdPartyLibraries(_ app: UIApplication, _ options: [UIApplication.LaunchOptionsKey: Any]?) {
        // TODO: - setup third party libraries, SDKs, dependencies etc.
    }
}

