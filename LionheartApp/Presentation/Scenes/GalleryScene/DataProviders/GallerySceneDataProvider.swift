//
//  GallerySceneDataProvider.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 14.02.21.
//

import UIKit

protocol GallerySceneDataProviderDelegate: AnyObject {
    func didSelectImage(_ imageId: String)
}

final class GallerySceneDataProvider: NSObject {
    
    // MARK: - Private Properties -
    
    private let cellIdentifier = GalleryCell.uniqueIdentifier
    private weak var collectionView: UICollectionView!
    private var cellStyle: GalleryCellStylable!
    private var layouts: GallerySceneLayouts?
    
    // MARK: - Delegate -
    
    weak var delegate: GallerySceneDataProviderDelegate?
    
    // MARK: - Lifecycle -
    
    init(_ collectionView: UICollectionView, _ cellStyle: GalleryCellStylable) {
        super.init()
        self.collectionView = collectionView
        self.cellStyle = cellStyle
        setup()
    }
    
    func load(_ data: GallerySceneLayouts) {
        self.layouts = data
        collectionView.reloadData()
    }
    
}

private extension GallerySceneDataProvider {
    
    func setup() {
        collectionView.register(GalleryCell.self,
                                forCellWithReuseIdentifier: cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
    }
    
}

extension GallerySceneDataProvider: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let cellViewModel = layouts?.getCellViewModel(for: indexPath.item) else { return }
        delegate?.didSelectImage(cellViewModel.imageId)
    }
    
}

extension GallerySceneDataProvider: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        layouts?.numberOfSections() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        layouts?.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? GalleryCell,
              let cellViewModel = layouts?.getCellViewModel(for: indexPath.item) else {
            fatalError(.failedToDequeueCell)
        }
        cell.configure(cellViewModel, styleSheet: cellStyle)
        return cell
    }
    
}
