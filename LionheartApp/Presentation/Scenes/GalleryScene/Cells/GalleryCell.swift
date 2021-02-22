//
//  GalleryCell.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 21.02.21.
//

import UIKit

final class GalleryCell: UICollectionViewCell {
    
    // MARK: - Private Properties -
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var titleLabel = UILabel()
    
    private var viewModel: GalleryCellViewModel?
    private var styleSheet: GalleryCellStylable!
    private var cancalable: NetworkCancellable?
    
    private lazy var _setupLayout: Void = setupLayout()
    
    // MARK: - Public Methods -
    
    func configure(_ viewModel: GalleryCellViewModel, styleSheet: GalleryCellStylable) {
        self.viewModel = viewModel
        self.styleSheet = styleSheet
        setup()
        loadData()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        
        cancalable?.cancel()
        cancalable = nil
        
    }
    
}

// MARK: - Private Methods

private extension GalleryCell {
    
    func setup() {
        // this will initialise only once
        _ = _setupLayout
    }
    
    func loadData() {
        cancalable = viewModel?.loadImage { [weak self] result in
            switch result {
            case .success(let image):
                self?.imageView.image = image
            case .failure(_):
                break
            }
        }
    }
    
    func setupLayout() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        
        // apply drop shadow effect
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.shadowRadius = 4.0
        titleLabel.layer.shadowOpacity = 1.0
        titleLabel.layer.shadowOffset = CGSize(width: 0, height: 3)
        titleLabel.layer.masksToBounds = false
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        titleLabel.font = styleSheet.titleFont
        titleLabel.textColor = styleSheet.titleColor
        
        contentView.backgroundColor = styleSheet.backgroundColor
        
    }
    
}

// MARK: - Styles -

protocol GalleryCellStylable {
    var backgroundColor: UIColor { get }
    var titleFont: UIFont { get }
    var titleColor: UIColor { get }
}

extension GalleryCell {
    class StyleSheet: GalleryCellStylable {
        
        var backgroundColor: UIColor
        var titleFont: UIFont
        var titleColor: UIColor
        
        init(backgroundColor: UIColor, titleFont: UIFont, titleColor: UIColor) {
            self.backgroundColor = backgroundColor
            self.titleFont = titleFont
            self.titleColor = titleColor
        }
        
    }
}
