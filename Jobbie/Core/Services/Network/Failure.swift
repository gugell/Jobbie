//
//  Failure.swift
//  Jobbie
//
//  Created by Ilia Gutu on 28.01.2022.
//

import Foundation

public enum Failure: Error, Equatable {

    case invalidURL(_ url: String)
    case badResponse
    case nonHTTPResponse
    case badStatusCode(_ code: Int)
    case underlying(_ error: Error?)
    case jsonMapping(Error)
    case encoding(Error)

    var localizedDescription: String {
        switch self {
        case .badResponse:
            return "Bad response"
        case .nonHTTPResponse:
            return "Non HTTP response"
        case .badStatusCode(let statusCode):
            return "Status code \(statusCode) didn't fall within the given range."
        case .underlying(let error):
            return error?.localizedDescription ?? "Something went wrong."
        case .invalidURL(let url):
            return "Provided url \(url) seems to be invalid"
        case .jsonMapping(let error):
            return "Failed to map object.Error: \n\(error.localizedDescription)"
        case .encoding(let error):
            return "Failed to encode with error:  \(error.localizedDescription)"
        }
    }

    init(error: Error?) {
        if let failure = error as? Failure {
            self = failure
        } else {
            self = .underlying(error)
        }
    }

    public static func == (lhs: Failure, rhs: Failure) -> Bool {
        switch (lhs, rhs) {
        case (.badResponse, .badResponse):
            return true
        case (.nonHTTPResponse, .nonHTTPResponse):
            return true
        case (.badStatusCode(let lhsCode), .badStatusCode(let rhsCode)):
            return lhsCode == rhsCode
        case (.underlying(let lhsError), .underlying(let rhsError)):
            return lhsError?.localizedDescription == rhsError?.localizedDescription
        default:
            return false
        }
    }
}
