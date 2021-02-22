//
//  UseCase.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 16.02.21.
//

import Foundation

protocol UseCase {
    
    associatedtype Response
    associatedtype Request
    
    typealias CompletionHandler = (_ result: Result<Response, Error>) -> Void
    
    func execute(_ request: Request?, _ completion: @escaping CompletionHandler) -> NetworkCancellable?
    
}
