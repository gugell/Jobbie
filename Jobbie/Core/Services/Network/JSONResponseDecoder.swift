//
//  JSONResponseDecoder.swift
//  Jobbie
//
//  Created by Ilia Gutu on 28.01.2022.
//

import Foundation

final class JSONResponseDecoder {

    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return decoder
    }()

    func mapObject<T: Codable>(ofType type: T.Type,
                               from data: Data,
                               at path: String? = nil) throws -> T {
        do {
            return try decoder.decode(T.self, from: try getJsonData(from: data, path))
        } catch {
            debugPrint(error.localizedDescription)
            debugPrint((error as? DecodingError).debugDescription)
            throw Failure.jsonMapping(error)
        }
    }

    func mapArray<T: Codable>(ofType type: T.Type,
                              from data: Data,
                              path: String? = nil) throws -> [T] {

        do {
            return try decoder.decode([T].self, from: try getJsonData(from: data, path))
        } catch {
            debugPrint(error)
            throw DecodingFailure.jsonMapping(error)
        }
    }

    private func getJsonData(from data: Data, _ path: String? = nil) throws -> Data {
        do {
            var jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
            if let path = path {
                guard let specificObject = jsonObject.value(forKeyPath: path) else {
                    throw DecodingFailure.badData
                }
                jsonObject = specificObject as AnyObject
            }

            return try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
        } catch {
            throw DecodingFailure.jsonMapping(error)
        }
    }
}

enum DecodingFailure: Error, Equatable {
    case jsonMapping(Error)
    case badData
    case underlying(Error?)

    var localizedDescription: String {
        switch self {
        case .badData:
            return "Bad data to decode"
        case .underlying(let error):
            return error?.localizedDescription ?? "Something went wrong"
        case .jsonMapping(let error):
            return "Failed to map object.Error: \n\(error.localizedDescription)"
        }
    }

    init(error: Error?) {
        if let failure = error as? DecodingFailure {
            self = failure
        } else {
            self = .underlying(error)
        }
    }

    public static func == (lhs: DecodingFailure, rhs: DecodingFailure) -> Bool {
        switch (lhs, rhs) {
        case (.badData, .badData):
            return true
        case (.jsonMapping(let lhsError), .jsonMapping(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.underlying(let lhsError), .underlying(let rhsError)):
            return lhsError?.localizedDescription == rhsError?.localizedDescription
        default:
            return false
        }
    }
}
