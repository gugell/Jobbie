//
//  Request.swift
//  Jobbie
//
//  Created by Ilia Gutu on 28.01.2022.
//

import Foundation

protocol CachePolicyGettableType {
    var cachePolicy: URLRequest.CachePolicy? { get }
}

protocol AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? { get }
}

protocol StubRequest {
    var fileName: String? { get }
}

enum AuthorizationType: String {
    case basic = "Basic"
    case bearer = "Bearer"
}

protocol Request: CachePolicyGettableType, AccessTokenAuthorizable, StubRequest {
    var baseURL: URL { get }
    var path: String { get }
    var method: Method { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var encoding: ParameterEncoding { get }
}

extension Request {
    var cachePolicy: URLRequest.CachePolicy? {
        return .reloadIgnoringLocalAndRemoteCacheData
    }

    var authorizationType: AuthorizationType? {
        return nil
    }
}

enum Method: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
    case delete = "DELETE"
}

extension Request {
    func asUrlRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        if let cachePolicy = cachePolicy {
            request.cachePolicy = cachePolicy
        }
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers

        return try encoding.encode(request, with: parameters)
    }
}
