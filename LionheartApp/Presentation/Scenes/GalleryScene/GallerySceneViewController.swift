//
//  GallerySceneViewController.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 14.02.21.
//

import UIKit

class GallerySceneViewController: UIViewController {
    
    // MARK: - Components -
    
    private lazy var collectionViewLayout = GalleryCollectionViewLayout.new()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = styles.backgroundColor
        return collectionView
    }()
    
    private lazy var dataProvider: GallerySceneDataProvider = {
        let dataProvider = GallerySceneDataProvider(collectionView, styles.cellStyle)
        dataProvider.delegate = self
        return dataProvider
    }()
    
    // MARK: - Properties -
    
    private var viewModel: GallerySceneViewModelable!
    private var styles: GallerySceneStylable!
    
    // MARK: - ViewController Lifecycle -
    
    init(_ viewModel: GallerySceneViewModelable,
         _ styles: GallerySceneStylable) {
        self.viewModel = viewModel
        self.styles = styles
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        requestData()
    }
    
}

// MARK: - Private Logic -

private extension GallerySceneViewController {
    
    func setup() {
        view.backgroundColor = styles.backgroundColor
        
        // setup collection view constraints
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func requestData() {
        viewModel.requestGalleryData { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let layouts):
                self.dataProvider.load(layouts)
            break
            case .failure(_):
                // TODO: Handle Errors
                break
            }
            
        }
    }
    
}

// MARK: - GallerySceneDataProviderDelegate -

extension GallerySceneViewController: GallerySceneDataProviderDelegate {
    
    func didSelectImage(_ imageId: String) {
        viewModel.didSelectImage(imageId)
    }
    
}

// MARK: - Styles -

protocol GallerySceneStylable {
    var backgroundColor: UIColor { get }
    var cellStyle: GalleryCellStylable { get }
}

extension GallerySceneViewController {
    
    struct DefaultGallerySceneStyles: GallerySceneStylable {
        var backgroundColor: UIColor
        var cellStyle: GalleryCellStylable
    }
    
}
