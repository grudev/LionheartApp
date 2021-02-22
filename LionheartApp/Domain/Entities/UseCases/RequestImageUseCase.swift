//
//  RequestImageUseCase.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 21.02.21.
//

import UIKit

final class RequestImageUseCase: UseCase {
    
    typealias Response = UIImage
    typealias Request = String
    
    private let repository: ImageRepository
    
    init(_ repository: ImageRepository) {
        self.repository = repository
    }
    
    func execute(_ request: Request?, _ completion: @escaping ImageResultType) -> NetworkCancellable? {
        guard let request = request else { return nil }
        return repository.getImage(request, completion)
    }
    
}
