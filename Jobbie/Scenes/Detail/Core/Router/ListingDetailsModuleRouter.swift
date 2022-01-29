//
//  ListingDetailsModuleRouter.swift
//  Jobbie
//
//  Created by Ilia Gutu on 29.01.2022.
//

import Foundation
import UIKit

/// Modules router input
protocol ListingDetailsModuleRouterInput: AnyObject {
    /// Dismiss the screen
    func dismiss()
}

/// Modules router
final class ListingDetailsModuleRouter: ListingDetailsModuleRouterInput {

    let coordinator: DetailsFlowCoordinatorInput

    init(coordinator: DetailsFlowCoordinatorInput) {
        self.coordinator = coordinator
    }

    func dismiss() {
        coordinator.dismiss()
    }
}
