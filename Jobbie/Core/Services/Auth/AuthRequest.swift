//
//  AuthRequest.swift
//  Jobbie
//
//  Created by Ilia Gutu on 28.01.2022.
//

import Foundation

enum AuthRequest: Request {
    case login(credentials: Credentials)

    var baseURL: URL {
        return AppEnvironment.baseURL
    }

    var path: String {
        switch self {
        case .login:
            return "/api/employee/v1/auth"
        }
    }

    var method: Method {
        return .post
    }

    var headers: [String : String]? {
        return nil
    }

    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }

    var parameters: [String : Any]? {
        switch self {
        case .login(let credentials):
            return [
                "username": credentials.username,
                "password": credentials.password,
            ]
        }
    }
}
