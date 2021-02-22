//
//  APIRouter.swift
//  LionheartApp
//
//  Created by Dimitar Grudev on 16.02.21.
//

import Foundation

enum APIRouter {
    
    static let baseUrl = "https://api.imgur.com/3/"
    static let baseImageUrl = "https://i.imgur.com/"
    
    // MARK: - Endpoints -
    
    case viralHotGallery
    case galleryImage(id: String)
    
    // MARK: - Convert to url request -
    
    func asURLRequest() throws -> URLRequest {
        
        var components: URLComponents!
        
        switch self {
        case .galleryImage:
            components = URLComponents(string: APIRouter.baseImageUrl)
        default:
            components = URLComponents(string: APIRouter.baseUrl)
        }
        
        var urlQueryItems = components.queryItems ?? [URLQueryItem]()
        parameters?.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        
        components.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
        guard let url = components.url else { throw AppDomainError.failedToResolveBaseUrl }
        
        var urlRequest = URLRequest(url: url.absoluteURL.appendingPathComponent(path))
        urlRequest.httpMethod = method
        addDefaultHeaders(&urlRequest)
        return urlRequest
        
    }
    
}

// MARK: - Private Logic -

private extension APIRouter {
    
    var method: String {
        switch self {
        // TODO: - handle more http methods
        default:
            return "GET"
        }
    }
    
    var path: String {
        switch self {
        case .viralHotGallery:
            return "gallery/hot/viral/0.json"
        case .galleryImage(let id):
            return "\(id).jpg"
        }
    }
    
    var parameters: [String: String]? {
        return nil
    }
    
    // NOTE: - Authorise for public use only, no user authentication -
    func addDefaultHeaders(_ request: inout URLRequest) {
        request.addValue("Client-ID \(Constants.API.clientId)", forHTTPHeaderField: "Authorization")
    }
    
}
