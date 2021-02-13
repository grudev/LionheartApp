//
//  AppInitialiser.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 13.02.21.
//

import UIKit

final class AppInitialiser {
    
    private let window: UIWindow
    private let container: MainCoordinatorDIContainer!
    private lazy var coordinator = MainCoordinator(window: window, container)
    
    init(window: UIWindow, _ container: MainCoordinatorDIContainer) {
        self.window = window
        self.container = container
    }
    
    func initialise(_ app: UIApplication, _ options: [UIApplication.LaunchOptionsKey: Any]?) {
        setupThirdPartyLibraries(app, options)
        AppTheme.applyGeneralTheme()
        coordinator.start()
    }
    
}

private extension AppInitialiser {
    func setupThirdPartyLibraries(_ app: UIApplication, _ options: [UIApplication.LaunchOptionsKey: Any]?) {
        // TODO: - setup third party libraries, SDKs, dependencies etc.
    }
}

