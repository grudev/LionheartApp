//
//  MainCoordinator.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 13.02.21.
//

import UIKit

protocol MainCoordinatorDIContainer {
    
}

final class MainCoordinator: Coordinatable {
    
    // MARK: - Properties
    
    private let window: UIWindow!
    
    var parentCoordinator: Coordinatable?
    var childCoordinators: [Coordinatable]?
    lazy var navigationController = UINavigationController()
    var rootViewController: UIViewController?
    var rootScreenId: String?
    
    // MARK: - DI Container
    
    private let container: MainCoordinatorDIContainer!
    
    // MARK: - Coordinator Lifecycle
    
    init(window: UIWindow?, _ container: MainCoordinatorDIContainer) {
        self.window = window
        self.container = container
        
        navigationController.view.backgroundColor = AppTheme.Colors.white
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        presentGalleryScene()
    }
    
}

private extension MainCoordinator {
    
    func presentGalleryScene() {
        
    }

}
