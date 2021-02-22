//
//  AppTheme.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 13.02.21.
//

import UIKit

final class AppTheme {
    
    // MARK: - Color Definitions
    
    struct Colors {
        
        static let green = UIColor(named: "green") ?? UIColor.black
        static let white = UIColor.white
        static let gray = UIColor.darkGray
        
        struct Text {
            static var `default`: UIColor { gray }
        }
        
    }
    
    struct Text {
        static func appFont(size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size)
        }
    }
    
    // MARK: - Apply General Theme
    
    static func applyGeneralTheme() {
        UINavigationBar.appearance().barTintColor = Colors.green
        UINavigationBar.appearance().tintColor = Colors.white
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: Colors.white
        ]
        UINavigationBar.appearance().isTranslucent = false

        UIToolbar.appearance().barTintColor = Colors.green
        UIToolbar.appearance().tintColor = Colors.green
    }
    
}

extension AppTheme {
    
    static func makeGallerySceneStyles() -> GallerySceneStylable {
        
        let cellStyle = GalleryCell.StyleSheet(backgroundColor: Colors.white,
                                               titleFont: Text.appFont(size: 18),
                                               titleColor: Colors.white)
        
        return GallerySceneViewController.DefaultGallerySceneStyles(
            backgroundColor: Colors.white,
            cellStyle: cellStyle
        )
    }
    
    static func makeImageSceneStyles() -> ImageDetailSceneStylable {
        ImageDetailSceneViewController.DefaultImageDetailSceneStyles(
            backgroundColor: Colors.white,
            buttonFilterBackgroundColor: Colors.green
        )
    }
    
}
