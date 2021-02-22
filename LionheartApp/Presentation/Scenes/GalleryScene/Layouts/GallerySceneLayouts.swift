//
//  GallerySceneLayouts.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 22.02.21.
//

import Foundation

final class GallerySceneLayouts {
    
    private var cellViewModels = [GalleryCellViewModel]()
    
    init(_ parent: GalleryCellViewModelParent, _ images: [ImageMeta]) {
        cellViewModels = images.map { GalleryCellViewModel($0, parent) }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems() -> Int {
        cellViewModels.count
    }
    
    func getCellViewModel(for item: Int) -> GalleryCellViewModel {
        cellViewModels[item]
    }
    
}
