//
//  RequestGalleryUseCase.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 16.02.21.
//

import Foundation

final class RequestGalleryUseCase: UseCase {
    
    typealias Response = ResponseData<Gallery>
    typealias Request = Void?
    
    private let repository: GalleryRepository
    
    init(_ repository: GalleryRepository) {
        self.repository = repository
    }
    
    func execute(_ request: Request, _ completion: @escaping GalleryResultType) -> NetworkCancellable? {
        repository.getGallery(completion)
    }
    
}
