//
//  Identifiable.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 13.02.21.
//

import Foundation

public protocol Identifiable {
    static var uniqueIdentifier: String { get }
}

public extension Identifiable {
    static var uniqueIdentifier: String { String(describing: self) }
}

extension NSObject: Identifiable { }
