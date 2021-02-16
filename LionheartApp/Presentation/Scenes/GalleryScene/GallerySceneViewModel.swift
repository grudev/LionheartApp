//
//  GallerySceneViewModel.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 14.02.21.
//

import UIKit

typealias GalleryType = ResponseData<Gallery>
typealias RequestGalleryCompletionType = (_ response: Result<GalleryType, Error>) -> Void

protocol GallerySceneViewModelable {
    func requestGalleryData(_ completion: @escaping RequestGalleryCompletionType)
}

class GallerySceneViewModel: GallerySceneViewModelable {
    
    func requestGalleryData(_ completion: @escaping RequestGalleryCompletionType) {
        
    }
    
}
