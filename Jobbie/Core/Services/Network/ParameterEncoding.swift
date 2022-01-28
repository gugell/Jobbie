//
//  ParameterEncoding.swift
//  Jobbie
//
//  Created by Ilia Gutu on 28.01.2022.
//

import Foundation

public typealias Parameters = [String: Any]

protocol ParameterEncoding {
    func encode(_ request: URLRequest, with parameters: Parameters?) throws -> URLRequest
}

struct JSONEncoding: ParameterEncoding {

    public static let `default` = JSONEncoding()

    public func encode(_ request: URLRequest, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = request

        guard let parameters = parameters else { return urlRequest }

        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: [])

            let contentTypeHeaderName = "Content-Type"
            if urlRequest.value(forHTTPHeaderField: contentTypeHeaderName) == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: contentTypeHeaderName)
            }

            urlRequest.httpBody = data
        } catch {
            throw Failure.encoding(error)
        }

        return urlRequest
    }
}

struct URLEncoding: ParameterEncoding {
    public static let `default` = URLEncoding()

    public func encode(_ request: URLRequest, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = request

        guard let parameters = parameters else { return urlRequest }

        guard let url = urlRequest.url,
                var urlComponents = URLComponents(url: url,
                                                resolvingAgainstBaseURL: true) else { return urlRequest }
        let queryItems = parameters.map { URLQueryItem(name: $0.0, value: "\($0.1)") }
        urlComponents.queryItems = queryItems
        urlRequest.url = urlComponents.url ?? urlRequest.url

        return  urlRequest
    }
}
