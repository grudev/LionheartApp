//
//  MainCoordinator.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 13.02.21.
//

import UIKit

protocol MainCoordinatorDIContainer {
    
    // MARK: - Gallery Scene
    
    func makeGallerySceneViewModel(_ callbacks: GallerySceneViewModelCallbacks) -> GallerySceneViewModelable
    func makeGallerySceneViewController(_ viewModel: GallerySceneViewModelable) -> GallerySceneViewController
    
    // MARK: - Image Detail Scene
    
    func makeImageDetailViewModel(_ imageId: String,
                                  _ callbacks: ImageDetailSceneViewModelCallbacks) -> ImageDetailSceneViewModelable
    
    func makeImageDetailViewController(_ viewModel: ImageDetailSceneViewModelable) -> ImageDetailSceneViewController
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
        
        let _imageSelected = { [weak self] (imageId: String) -> Void in
            self?.presentImageDetailScene(imageId)
        }
        
        let callbacks = GallerySceneViewModelCallbacks(onImageSelected: _imageSelected)
        let viewModel = container.makeGallerySceneViewModel(callbacks)
        let viewController = container.makeGallerySceneViewController(viewModel)
        navigationController.pushViewController(viewController, animated: false)
        
    }
    
    func presentImageDetailScene(_ imageId: String) {
        
        let _onShare = { [weak self] (_ image: UIImage) -> Void in
            guard let self = self else { return }
            
        }
        
        let _onBack = { [weak self] () -> Void in
            guard let self = self else { return }
            self.navigationController.popToRootViewController(animated: true)
        }
        
        let callbacks = ImageDetailSceneViewModelCallbacks(onShareButtonPressed: _onShare,
                                                           onBackButtonPressed: _onBack)
        let viewModel = container.makeImageDetailViewModel(imageId,
                                                           callbacks)
        let viewController = container.makeImageDetailViewController(viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

}
