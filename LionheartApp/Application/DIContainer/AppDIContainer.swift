//
//  AppDIContainer.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 13.02.21.
//

import UIKit

final class AppDIContainer {
    
    // TODO: - Add App Storages, Services, Network Managers etc.
    // TODO: - Handle object instances, control their lifecycle, reuse them from memory pool or dispose them
    
    private let networkManager: NetworkManager = DefaultNetworkManager()
    
}

// MARK: - MainCoordinatorDIContainer

extension AppDIContainer: MainCoordinatorDIContainer {
    
    func makeGallerySceneViewModel(_ callbacks: GallerySceneViewModelCallbacks) -> GallerySceneViewModelable {
        GallerySceneViewModel(callbacks, makeGalleryUseCase(), makeImageUseCase())
    }
    
    func makeGallerySceneViewController(_ viewModel: GallerySceneViewModelable) -> GallerySceneViewController {
        GallerySceneViewController(viewModel, AppTheme.makeGallerySceneStyles())
    }
    
    func makeImageDetailViewModel(_ imageId: String,
                                  _ callbacks: ImageDetailSceneViewModelCallbacks) -> ImageDetailSceneViewModelable {
        ImageDetailSceneViewModel(imageId, callbacks, makeImageUseCase())
    }
    
    func makeImageDetailViewController(_ viewModel: ImageDetailSceneViewModelable) -> ImageDetailSceneViewController {
        ImageDetailSceneViewController(viewModel, AppTheme.makeImageSceneStyles())
    }
    
}

// MARK: - UseCases -

private extension AppDIContainer {
    
    func makeGalleryUseCase() -> RequestGalleryUseCase {
        RequestGalleryUseCase(makeGalleryRepository())
    }
    
    func makeImageUseCase() -> RequestImageUseCase {
        RequestImageUseCase(makeImageRepository())
    }

}

// MARK: - Repositories -

private extension AppDIContainer {
    
    func makeGalleryRepository() -> GalleryRepository {
        NetworkGalleryRepository(networkManager)
    }
    
    func makeImageRepository() -> ImageRepository {
        NetworkImageRepository(networkManager)
    }
    
}
