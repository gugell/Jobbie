//
//  MockResponse.swift
//  JobbieTests
//
//  Created by Ilia Gutu on 28.01.2022.
//
import Foundation

extension HTTPURLResponse {
    static func mocked(status: Int, url: URL = .mocked()) -> HTTPURLResponse? {
        return HTTPURLResponse(url: url, statusCode: status, httpVersion: nil, headerFields: nil)
    }
}

extension URL {
    static func mocked(path: String =  "zenjob.org") -> URL {
        return URL(string: path)!
    }
}
