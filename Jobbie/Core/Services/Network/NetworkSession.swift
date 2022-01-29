//
//  NetworkSession.swift
//  Jobbie
//
//  Created by Ilia Gutu on 28.01.2022.
//

import Foundation

protocol NetworkSession {
    func executeTask(with request: URLRequest,
                     completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Task
}
protocol Task {
    func resume()
    func cancel()
}

extension URLSession: NetworkSession {
    func executeTask(with request: URLRequest,
                     completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Task {
        return dataTask(with: request, completionHandler: completionHandler)
    }
}
extension URLSessionTask: Task { }
