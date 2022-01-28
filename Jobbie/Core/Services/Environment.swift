//
//  Environment.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import Foundation

public struct Environment {

    static let current = Environment()

    let lookupService: LookupService
    let authService: AuthServices
    let baseURL: URL

    init(lookupService: LookupService? = nil,
         authService: AuthServices? = nil,
         baseURL: URL = URL(string: "https://staging-main.zenjob.org")!) {
        self.baseURL = baseURL
        let requestDispatcher = NetworkRequestDispatcher(session: URLSession.shared)
        self.lookupService = lookupService ?? LookupServiceImpl(requestDispatcher: requestDispatcher)
        self.authService = AuthServicesImpl(requestDispatcher: requestDispatcher)
    }
}
