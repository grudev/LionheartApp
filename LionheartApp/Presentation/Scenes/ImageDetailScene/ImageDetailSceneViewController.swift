//
//  ImageDetailSceneViewController.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 14.02.21.
//

import UIKit
import CoreImage
import CoreImage.CIFilterBuiltins
import LionheartActivity

class ImageDetailSceneViewController: UIViewController {
    
    // MARK: - Components -
    
    private lazy var activityIndicator: LionheartActivityIndicator = {
        let indicator = LionheartActivityIndicator.instantiate()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var applyFilterButton: UIButton = {
        let button = UIButton()
        // TODO: - Localize this
        let _localizedTitle = "Apply Filter"
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        button.setTitle(_localizedTitle, for: .normal)
        button.setTitle(_localizedTitle, for: .highlighted)
        button.setTitleColor(styles.buttonFilterTitleNormalColor, for: .normal)
        button.setTitleColor(styles.buttonFilterTitleDisabledColor, for: .disabled)
        button.backgroundColor = styles.buttonFilterBackgroundColor
        button.layer.cornerRadius = 5
        button.sizeToFit()
        return button
    }()
    
    private lazy var shareButton: UIBarButtonItem = {
        let item = UIBarButtonItem(barButtonSystemItem: .action,
                                   target: self,
                                   action: #selector(onShareButtonPressed))
        item.tintColor = .white
        navigationController?.topViewController?.navigationItem.rightBarButtonItem = item
        return item
    }()
    
    // MARK: - Properties -
    
    private var imageCancalable: NetworkCancellable?
    
    private var currentFilter = CIFilter.sepiaTone()
    private let context = CIContext()
    
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
        loadImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cleanup()
    }
    
}

// MARK: - Private Logic

private extension ImageDetailSceneViewController {
    
    func setup() {
        
        view.backgroundColor = styles.backgroundColor
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        // iPhone layout
        if UIDevice.current.userInterfaceIdiom == .phone {
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
                imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1),
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
            ])
        } else {
            // iPad layout
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
                imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1),
                imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
            ])
        }
        
        applyFilterButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(applyFilterButton)
        NSLayoutConstraint.activate([
            applyFilterButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            applyFilterButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
        ])
        applyFilterButton.addTarget(self, action: #selector(onApplyFilterPressed), for: .touchUpInside)
        
        _ = shareButton
        enableUIComponents(false)
    }
    
    func loadImage() {
        showActivityIndicator()
        imageCancalable = viewModel.requestImage { [weak self] result in
            guard let self = self else { return }
            self.removeActivityIndicator()
            switch result {
            case .success(let image):
                self.imageView.image = image
                self.enableUIComponents(true)
            case .failure:
                self.enableUIComponents(false)
            }
        }
    }
    
    @objc
    func onApplyFilterPressed() {
        
        guard let image = imageView.image else {
            onFilterApplyingError()
            return
        }
        
        guard let ciImage = CIImage(image: image) else {
            onFilterApplyingError()
            return
        }
        
        let sepiaFilter = CIFilter(name: K.filterName)
        sepiaFilter?.setValue(ciImage, forKey: kCIInputImageKey)
        sepiaFilter?.setValue(K.filterIntensity, forKey: kCIInputIntensityKey)
        
        guard let outputImage = sepiaFilter?.outputImage else {
            onFilterApplyingError()
            return
        }
        
        imageView.image = UIImage(ciImage: outputImage)
        
    }
    
    @objc
    func onShareButtonPressed() {
        guard let image = imageView.image else { return }
        viewModel.onShareButtonPressed(image)
    }
    
    func onFilterApplyingError() {
        // TODO: -
    }
    
    func enableUIComponents(_ enable: Bool) {
        shareButton.isEnabled = enable
        applyFilterButton.isEnabled = enable
    }
    
    func showActivityIndicator() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
    
    func removeActivityIndicator() {
        activityIndicator.removeFromSuperview()
    }
    
    func cleanup() {
        imageCancalable?.cancel()
        imageCancalable = nil
    }
    
}

// MARK: - Styles -

protocol ImageDetailSceneStylable {
    var backgroundColor: UIColor { get }
    var buttonFilterBackgroundColor: UIColor { get }
    var buttonFilterTitleNormalColor: UIColor { get }
    var buttonFilterTitleDisabledColor: UIColor { get }
}

extension ImageDetailSceneViewController {
    
    struct DefaultImageDetailSceneStyles: ImageDetailSceneStylable {
        var backgroundColor: UIColor
        var buttonFilterBackgroundColor: UIColor
        var buttonFilterTitleNormalColor: UIColor
        var buttonFilterTitleDisabledColor: UIColor
    }
    
}

// MARK: - Constants

private extension ImageDetailSceneViewController {
    struct K {
        static let filterName = "CISepiaTone"
        static let filterIntensity: CGFloat = 0.8
    }
}
