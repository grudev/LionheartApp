//
//  GalleryRepository.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 16.02.21.
//

import Foundation

typealias GalleryDataType = ResponseData<[Gallery]>
typealias GalleryResultType = (Result<GalleryDataType, Error>) -> Void

protocol GalleryRepository {
    init(_ networkManager: NetworkManager)
    func getGallery(_ completion: @escaping GalleryResultType) -> NetworkCancellable?
}

final class NetworkGalleryRepository: GalleryRepository {
    
    private var networkManager: NetworkManager!
    
    init(_ networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getGallery(_ completion: @escaping GalleryResultType) -> NetworkCancellable? {
        do {
            let request = try APIRouter.viralHotGallery.asURLRequest()
            let cancelable = networkManager.request(request, completion: completion)
            return cancelable
        } catch {
            completion(.failure(error))
            return nil
        }
    }
    
}
