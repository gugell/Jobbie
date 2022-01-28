//
//  AuthModuleInteractor.swift
//  Jobbie
//
//  Created by Ilia Gutu on 28.01.2022.
//

import Foundation

/// Modules interactor input
protocol AuthModuleInteractorInput: AnyObject {
  /// Autheticate with default credentials
  func authenticate()
}

/// Modules interactor output
protocol AuthModuleInteractorOutput: AnyObject {
  /// Notifies that interactor finished loading listings
    func interactorDidFinishSignin()
    func interactorDidFailWithError(_ error: String)
}

final class AuthModuleInteractor: AuthModuleInteractorInput {

    weak var output: AuthModuleInteractorOutput!
    private let authService: AuthServices

    init(authService: AuthServices) {
        self.authService = authService
    }

    func authenticate() {
        authService.signIn(with: .default) { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleAuthResponse(response)
                self?.output?.interactorDidFinishSignin()
            case .failure(let error):
                self?.output?.interactorDidFailWithError(error.localizedDescription)
            }
        }
    }

    private func handleAuthResponse(_ user: User) {

    }
}
