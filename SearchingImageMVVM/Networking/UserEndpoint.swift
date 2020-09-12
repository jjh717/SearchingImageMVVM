//
//  UserEndpoint.swift
//  SearchingImageMVVM
//
//  Created by Jang Dong Min on 2020/09/07.
//  Copyright © 2020 jdm. All rights reserved.
//
import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

enum UserEndpoint: APIConfiguration {
    case getImageList(page: Int)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
            case .getImageList:
                return .get
        }
    }

    // MARK: - Path
    var path: String {
        switch self {
        case .getImageList:
            return "/photos"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .getImageList(let page):
            return ["page" : page, "per_page" : 20]
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try ApiInfo.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue("Client-ID \(ApiInfo.appKey)", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
