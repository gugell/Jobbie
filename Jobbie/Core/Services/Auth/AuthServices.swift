//
//  AuthServices.swift
//  Jobbie
//
//  Created by Ilia Gutu on 28.01.2022.
//

import Foundation

protocol AuthServices {
    func signIn(with credentials: Credentials, completionHandler: @escaping  (Result<User, Failure>) -> Void)
}

final class AuthServicesImpl: AuthServices {
    private let requestDispatcher: RequestDispatcher

    init(requestDispatcher: RequestDispatcher) {
        self.requestDispatcher = requestDispatcher
    }

    func signIn(with credentials: Credentials, completionHandler: @escaping (Result<User, Failure>) -> Void) {
        requestDispatcher.dataTask(with: AuthRequest.login(credentials: credentials)) { result in
            switch result {
            case .success(let data):
                do {
                    let user = try JSONResponseDecoder().mapObject(ofType: User.self,
                                                                    from: data)
                    completionHandler(.success(user))
                } catch {
                    debugPrint("Failed to decode JSON", error.localizedDescription)
                    completionHandler(.failure(.underlying(error)))
                }
            case .failure(let error):
                completionHandler(.failure(Failure(error: error)))
            }
        }?.resume()
    }
}
