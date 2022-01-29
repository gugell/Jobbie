//
//  OffersRequest.swift
//  Jobbie
//
//  Created by Ilia Gutu on 28.01.2022.
//

import Foundation

enum OffersRequest: Request {

    case offers(offset: Int?)
    case offer(String)

    var baseURL: URL {
        return AppEnvironment.baseURL
    }

    var path: String {
        switch self {
        case .offers:
            return "/api/employee/v1/offers"
        case .offer(let id):
            return "/api/employee/v1/offers/\(id)"
        }
    }

    var method: Method {
        return .get
    }

    var headers: [String: String]? {
        return nil
    }

    var encoding: ParameterEncoding {
        return URLEncoding.default
    }

    var parameters: [String: Any]? {
        switch self {
        case .offers(let offset):
            return ["offset": offset ?? 0].compactMapValues { $0 }
        case .offer:
            return nil
        }
    }

    var authorizationType: AuthorizationType? {
        return .bearer
    }

    var fileName: String? {
        switch self {
        case .offers:
            return "offers.response"
        case .offer:
            return "offer.response"
        }
    }
}
