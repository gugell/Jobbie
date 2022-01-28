//
//  AuthModuleRouter.swift
//  Jobbie
//
//  Created by Ilia Gutu on 28.01.2022.
//

import Foundation
import UIKit

/// Modules router input
protocol AuthModuleRouterInput: AnyObject {
  /// Go next
    func navigateNext()
  /// Show error alert
  /// - Parameter error: Error to show
  /// - Parameter onRetry: Action to be invoked on retry
    func showErrorAlert(_ error: String, onRetry: @escaping EmptyAction)
}

/// Modules router
final class AuthModuleRouter: AuthModuleRouterInput {

    let coordinator: AuthFlowCoordinatorInput

    init(coordinator: AuthFlowCoordinatorInput) {
        self.coordinator = coordinator
    }

    func navigateNext() {
        coordinator.didFinishFlow()
    }

    func showErrorAlert(_ error: String, onRetry: @escaping EmptyAction) {
        let retryAction = Alert.Action(title: L10n.Action.retry,
                                       style: .default,
                                       handler: onRetry)
        let alert = Alert(title: L10n.Error.SignIn.title,
                     message: error,
                     actions: [retryAction, Alert.Action.cancel])
        coordinator.showAlert(alert)
    }
}
