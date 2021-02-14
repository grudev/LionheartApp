//
//  ImageDetailSceneViewController.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 14.02.21.
//

import UIKit

class ImageDetailSceneViewController: UIViewController {
    
    // MARK: - Properties -
    
    private var viewModel: ImageDetailSceneViewModelable!
    private var styles: ImageDetailSceneStylable!
    
    // MARK: - ViewController Lifecycle -
    
    init(_ viewModel: ImageDetailSceneViewModelable,
         _ styles: ImageDetailSceneStylable) {
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
    }
    
}

// MARK: - Private Logic

private extension ImageDetailSceneViewController {
    
    func setup() {
        view.backgroundColor = styles.backgroundColor
    }
    
}

// MARK: - Styles -

protocol ImageDetailSceneStylable {
    var backgroundColor: UIColor { get }
}

extension ImageDetailSceneViewController {
    
    struct DefaultImageDetailSceneStyles: ImageDetailSceneStylable {
        var backgroundColor: UIColor
    }
    
}
