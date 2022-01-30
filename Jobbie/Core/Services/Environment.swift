//
//  Environment.swift
//  Jobbie
//
//  Created by Ilia Gutu on 29.01.2022.
//

import Foundation

public struct Environment {

    static let current = Environment()

    let lookupService: LookupService
    let authService: AuthServices
    let userSession: UserSession
    let baseURL: URL

    init(lookupService: LookupService? = nil,
         authService: AuthServices? = nil,
         userSession: UserSession = UserSessionManager(),
         baseURL: URL = URL(string: "https://staging-main.zenjob.org")!) {
        self.baseURL = baseURL
        self.userSession = userSession
        // TODO: Inject real dispatcher if the API will fail
        let requestDispatcher = NetworkRequestDispatcher(session: URLSession.shared,
                                                         tokenClosure: { [weak userSession] in
            userSession?.accessToken })
        self.lookupService = lookupService ?? LookupServiceImpl(requestDispatcher: StubRequestDispatcher())
        self.authService = AuthServicesImpl(requestDispatcher: StubRequestDispatcher())
    }
}
