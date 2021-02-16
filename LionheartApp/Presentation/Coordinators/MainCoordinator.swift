//
//  MainCoordinator.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 13.02.21.
//

import UIKit

protocol MainCoordinatorDIContainer {
    func makeGallerySceneViewModel(_ callbacks: GallerySceneViewModelCallbacks) -> GallerySceneViewModelable
    func makeGallerySceneViewController(_ viewModel: GallerySceneViewModelable) -> GallerySceneViewController
}

final class MainCoordinator: Coordinatable {
    
    // MARK: - Properties
    
    private let window: UIWindow!
    
    var parentCoordinator: Coordinatable?
    var childCoordinators: [Coordinatable]?
    lazy var navigationController = UINavigationController()
    var rootViewController: UIViewController?
    
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
        
        let _imageSelected = { [weak self] (imageId: String) in
            // TODO - 
        }
        
        let callbacks = GallerySceneViewModelCallbacks(onImageSelected: _imageSelected)
        let viewModel = container.makeGallerySceneViewModel(callbacks)
        let viewController = container.makeGallerySceneViewController(viewModel)
        navigationController.pushViewController(viewController, animated: false)
        
    }

}
