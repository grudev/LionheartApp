//
//  RequestGalleryUseCase.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 16.02.21.
//

import Foundation

final class RequestGalleryUseCase: UseCase {
    
    typealias Response = ResponseData<[Gallery]>
    typealias Request = Void
    
    private let repository: GalleryRepository
    
    init(_ repository: GalleryRepository) {
        self.repository = repository
    }
    
    func execute(_ request: Request?, _ completion: @escaping GalleryResultType) -> NetworkCancellable? {
        repository.getGallery { result in
            switch result {
            case .success(let galleries):
                
                // NOTE: - Here's the place where we can process the raw response and return ready to use data on our presentation layer.
                
                // filter galleries without images property or empty one.
                let _filteredGalleries: [Gallery] = galleries.data.compactMap {
                    let hasNoImages = $0.images != nil
                    let isEmpty = $0.images?.isEmpty ?? false
                    return hasNoImages || isEmpty ? $0 : nil
                }
                
                let _filteredResponseData = ResponseData<[Gallery]>(data: _filteredGalleries,
                                                                    success: true,
                                                                    status: 200)
                completion(.success(_filteredResponseData))
                
            default:
                // propagate the error upwards
                completion(result)
            }
        }
    }
    
}
