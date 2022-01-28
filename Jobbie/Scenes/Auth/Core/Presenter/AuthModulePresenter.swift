//
//  AuthModulePresenter.swift
//  Jobbie
//
//  Created by Ilia Gutu on 28.01.2022.
//

import Foundation

final class AuthModulePresenter: AuthModuleViewOutput, AuthModuleInteractorOutput {

    weak var view: AuthModuleViewInput!
    var interactor: AuthModuleInteractorInput

    /// Router
    var router: AuthModuleRouterInput

    /// Initialization
    ///
    /// - Parameters:
    ///   - view: View
    ///   - interactor: Interactor
    ///   - router: Router
    init(view: AuthModuleViewInput,
         interactor: AuthModuleInteractorInput,
         router: AuthModuleRouterInput) {
      self.view = view
      self.interactor = interactor
      self.router = router
    }

    func viewDidLoad() {
        authenticate()
    }

    private func authenticate() {
        view?.showHUD()
        interactor.authenticate()
    }

    func interactorDidFailWithError(_ error: String) {
        UI { [weak self] in
            guard let self = self else { return }
            self.router.showErrorAlert(error, onRetry: self.authenticate)
        }
    }


    func interactorDidFinishSignin() {
        UI { [weak self] in
            self?.router.navigateNext()
        }
    }
}
