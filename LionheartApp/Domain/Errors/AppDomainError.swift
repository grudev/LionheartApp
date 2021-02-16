//
//  AppDomainError.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 13.02.21.
//

import UIKit

enum AppDomainError: String, Error {
    
    // MARK: - Presentation Errors
    case appWindowFailedToCreate = "fatal.error"
    
    // MARK: - Network Errors -
    case failedToResolveBaseUrl = "failed.to.resolve.base.url"
    
}

func fatalError(_ error: AppDomainError) -> Never {
    fatalError("ERROR: \(error.rawValue)")
}
