//
//  GalleryCellViewModel.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 21.02.21.
//

import UIKit

protocol GalleryCellViewModelParent: AnyObject {
    func requestImage(_ imageId: String, _ completion: @escaping RequestImageCompletionType) -> NetworkCancellable?
}

class GalleryCellViewModel {
    
    private weak var parent: GalleryCellViewModelParent?
    private var imageMeta: ImageMeta!
    
    var imageId: String { imageMeta.id }
    
    init(_ imageMeta: ImageMeta, _ parent: GalleryCellViewModelParent) {
        self.imageMeta = imageMeta
        self.parent = parent
    }
    
    func loadImage(_ completion: @escaping RequestImageCompletionType) -> NetworkCancellable? {
        parent?.requestImage(imageId, completion)
    }
    
}
