//
//  GallerySceneViewModel.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 14.02.21.
//

import UIKit

typealias GalleryType = ResponseData<[Gallery]>
typealias RequestGalleryCompletionType = (_ response: Result<GalleryType, Error>) -> Void

struct GallerySceneViewModelCallbacks {
    let onImageSelected: (_ id: String) -> Void
}

protocol GallerySceneViewModelable {
    func requestGalleryData(_ completion: @escaping RequestGalleryCompletionType)
    func didSelectImage(_ id: String)
}

typealias GalleryCompletionHandler = (Result<GalleryType, Error>) -> Void

class GallerySceneViewModel: GallerySceneViewModelable {
    
    // MARK: - Private Properties
    
    private let callbacks: GallerySceneViewModelCallbacks!
    private let galleryUseCase: RequestGalleryUseCase!
    
    // MARK: - Output Properties
    
    var galleryCompletion: GalleryCompletionHandler?
    
    // MARK: - ViewModel Lifecycle
    
    init(_ callbacks: GallerySceneViewModelCallbacks, _ galleryUseCase: RequestGalleryUseCase) {
        self.callbacks = callbacks
        self.galleryUseCase = galleryUseCase
    }
    
    func requestGalleryData(_ completion: @escaping RequestGalleryCompletionType) {
        // TODO: - Use returned cancalable or just @discardableResult to ignore returned data task
        let _ = galleryUseCase.execute(completion)
    }
    
    func didSelectImage(_ id: String) {
        callbacks.onImageSelected(id)
    }
    
}
