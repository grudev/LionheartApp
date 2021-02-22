//
//  LionheartActivityIndicator.swift
//  LionheartActivity
//
//  Created by Dimitar Grudev on 22.02.21.
//

import UIKit

open class LionheartActivityIndicator: UIView, NibInstantiable {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    open func setup(_ backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
}
