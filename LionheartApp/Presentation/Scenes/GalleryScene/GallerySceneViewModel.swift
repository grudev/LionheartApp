//
//  GallerySceneViewModel.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 14.02.21.
//

import UIKit

typealias GalleryType = ResponseData<[Gallery]>
typealias RequestGalleryCompletionType = (_ response: Result<GallerySceneLayouts, Error>) -> Void
typealias RequestImageCompletionType = (_ response: Result<UIImage, Error>) -> Void

struct GallerySceneViewModelCallbacks {
    let onImageSelected: (_ id: String) -> Void
}

protocol GallerySceneViewModelable {
    func requestGalleryData(_ completion: @escaping RequestGalleryCompletionType)
    func didSelectImage(_ id: String)
}

typealias GalleryCompletionHandler = (Result<GalleryType, Error>) -> Void

class GallerySceneViewModel: GallerySceneViewModelable, GalleryCellViewModelParent {
    
    // MARK: - Private Properties
    
    private let callbacks: GallerySceneViewModelCallbacks!
    private let galleryUseCase: RequestGalleryUseCase!
    private var imageUseCase: RequestImageUseCase!
    
    // MARK: - ViewModel Lifecycle
    
    init(_ callbacks: GallerySceneViewModelCallbacks,
         _ galleryUseCase: RequestGalleryUseCase,
         _ imageUseCase: RequestImageUseCase) {
        self.callbacks = callbacks
        self.galleryUseCase = galleryUseCase
        self.imageUseCase = imageUseCase
    }
    
    // MARK: - Public API - 
    
    func requestGalleryData(_ completion: @escaping RequestGalleryCompletionType) {
        // TODO: - Use returned cancalable or just @discardableResult to ignore returned data task
        let _ = galleryUseCase.execute(nil) { result in
            
            switch result {
            case .success(let galleryData):
                // Premap gallery data to useful images model, and pass it to GallerySceneLayouts
                let images = galleryData.data.compactMap { $0.images?.first ?? nil }
                completion(.success(GallerySceneLayouts(self, images)))
            case .failure(let error):
                // pass the error on parent without further processing
                completion(.failure(error))
            }
            
        }
    }
    
    func requestImage(_ imageId: String, _ completion: @escaping RequestImageCompletionType) -> NetworkCancellable? {
        return imageUseCase.execute(imageId, completion)
    }
    
    func didSelectImage(_ id: String) {
        callbacks.onImageSelected(id)
    }
    
}
