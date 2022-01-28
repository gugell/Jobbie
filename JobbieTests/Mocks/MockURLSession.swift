//
//  MockURLSession.swift
//  JobbieTests
//
//  Created by Ilia Gutu on 28.01.2022.
//
import Foundation
@testable import Jobbie

final class MockURLSession: NetworkSession {

    private (set) var lastURL: URL?
    var nextURLTask = MockURLSessionDataTask()
    var dataTaskResponseStub: (Data?, URLResponse?, Error?) = (nil, nil, nil)

    func executeTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Task {
        completionHandler(dataTaskResponseStub.0,
                          dataTaskResponseStub.1,
                          dataTaskResponseStub.2)
        lastURL = request.url
        return nextURLTask
    }
}
