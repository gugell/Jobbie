//
//  HomeModuleRouter.swift
//  Jobbie
//
//  Created by Ilia Gutu on 29.01.2022.
//

import Foundation
import UIKit

/// Modules router input
protocol HomeModuleRouterInput: AnyObject {
  /// Skip module and go next
    func showOfferDetails(_ offer: Offer)
  /// Show error alert
  /// - Parameter error: Error to show
  /// - Parameter onRetry: Action to be invoked on retry
    func showErrorAlert(_ error: String, onRetry: @escaping EmptyAction)
}

/// Modules router
final class HomeModuleRouter: HomeModuleRouterInput {

    let coordinator: HomeFlowCoordinatorInput

    init(coordinator: HomeFlowCoordinatorInput) {
        self.coordinator = coordinator
    }

    func showOfferDetails(_ offer: Offer) {
        coordinator.showOfferDetails(offer)
    }

    func showErrorAlert(_ error: String, onRetry: @escaping EmptyAction) {
        let retryAction = Alert.Action(title: L10n.Action.retry,
                                       style: .default,
                                       handler: onRetry)
        let alert = Alert(title: L10n.Error.Fetch.title,
                     message: error,
                     actions: [retryAction, Alert.Action.cancel])
        coordinator.showAlert(alert)
    }
}
