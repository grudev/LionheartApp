//
//  ImageDetailSceneViewModel.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 14.02.21.
//

import UIKit

struct ImageDetailSceneViewModelCallbacks {
    let onShareButtonPressed: (_ image: UIImage) -> Void
    let onBackButtonPressed: () -> Void
}

protocol ImageDetailSceneViewModelable {
    func requestImage(_ completion: @escaping RequestImageCompletionType) -> NetworkCancellable?
    func onShareButtonPressed(_ image: UIImage)
    func onBackButtonPressed()
}

class ImageDetailSceneViewModel: ImageDetailSceneViewModelable {
    
    // MARK: - Private Properties
    
    private var imageId: String!
    private var callbacks: ImageDetailSceneViewModelCallbacks!
    private var imageUseCase: RequestImageUseCase!
    
    // MARK: - ViewModel Lifecycle
    
    init(_ imageId: String,
         _ callbacks: ImageDetailSceneViewModelCallbacks,
         _ imageUseCase: RequestImageUseCase) {
        self.imageId = imageId
        self.callbacks = callbacks
        self.imageUseCase = imageUseCase
    }
    
    // MARK: - Public API -
    
    func requestImage(_ completion: @escaping RequestImageCompletionType) -> NetworkCancellable? {
        return imageUseCase.execute(imageId, completion)
    }
    
    func onShareButtonPressed(_ image: UIImage) {
        callbacks.onShareButtonPressed(image)
    }
    
    func onBackButtonPressed() {
        callbacks.onBackButtonPressed()
    }
    
}
