//
//  ImageRepository.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 21.02.21.
//

import UIKit

typealias ImageDataType = UIImage
typealias ImageResultType = (Result<ImageDataType, Error>) -> Void

protocol ImageRepository {
    init(_ networkManager: NetworkManager)
    func getImage(_ imageId: String, _ completion: @escaping ImageResultType) -> NetworkCancellable?
}

final class NetworkImageRepository: ImageRepository {
    
    private var networkManager: NetworkManager!
    
    init(_ networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getImage(_ imageId: String, _ completion: @escaping ImageResultType) -> NetworkCancellable? {
        do {
            let request = try APIRouter.galleryImage(id: imageId).asURLRequest()
            return networkManager.request(request, completion: completion)
        } catch {
            completion(.failure(error))
            return nil
        }
    }
    
}
