//
//  GallerySceneViewController.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 14.02.21.
//

import UIKit

class GallerySceneViewController: UIViewController {
    
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
    }
    
    func requestData() {
        viewModel.requestGalleryData { result in
            switch result {
            case .success(let galleries):
                print("Gallery status \(galleries.status), success: \(galleries.success), data: \(galleries.data)")
                
                let _filteredGalleries = galleries.data.compactMap { $0.images != nil ? $0 : nil }
                
                print("_filteredGalleries \(_filteredGalleries.count), galleries: \(galleries.data.count)")
                
            case .failure(let error):
                break
            }
        }
    }
    
}

// MARK: - Styles -

protocol GallerySceneStylable {
    var backgroundColor: UIColor { get }
}

extension GallerySceneViewController {
    
    struct DefaultGallerySceneStyles: GallerySceneStylable {
        var backgroundColor: UIColor
    }
    
}
