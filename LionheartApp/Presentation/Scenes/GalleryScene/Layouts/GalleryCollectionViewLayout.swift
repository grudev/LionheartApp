//
//  GalleryCollectionViewLayout.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 22.02.21.
//

import UIKit

final class GalleryCollectionViewLayout: UICollectionViewLayout {
    
    static func new() -> UICollectionViewLayout {
        
        let fullPhotoItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(2/3)
            )
        )

        fullPhotoItem.contentInsets = defaultInsets
        
        let mainItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(2/3),
                heightDimension: .fractionalHeight(1.0)
            )
        )

        mainItem.contentInsets = defaultInsets

        let pairItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)
            )
        )

        pairItem.contentInsets = defaultInsets
        
        let tripletItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        tripletItem.contentInsets = defaultInsets

        let tripletGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(2/9)
            ),
            subitems: [tripletItem, tripletItem, tripletItem]
        )
        
        let nestedGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(16/9)
            ),
            subitems: [fullPhotoItem, tripletGroup]
        )

        let section = NSCollectionLayoutSection(group: nestedGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private static let defaultInsets = NSDirectionalEdgeInsets(
        top: 2,
        leading: 2,
        bottom: 2,
        trailing: 2
    )
    
}
