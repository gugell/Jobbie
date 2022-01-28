//
//  ApplicationCoordinator.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import UIKit

final class ApplicationCoordinator: BaseCoordinator {

    private let wireframe: Wireframe

    init(wireframe: Wireframe) {
        self.wireframe = wireframe
        super.init()
    }

    override func start(with option: DeepLinkOption) {
        // start with deepLink
        if option != .unknown {
            childCoordinators.forEach { coordinator in
                coordinator.start(with: option)
            }
        } else {
            runAuthFlow()
        }
    }

    private func runAuthFlow() {
        let coordinator = AuthFlowCoordinator(wireframe: wireframe)
        coordinator.whenDone = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.runMainFlow()
        }
        addDependency(coordinator)
        coordinator.start()
    }

    private func runMainFlow() {
        let coordinator = HomeFlowCoordinator(wireframe: wireframe)
        addDependency(coordinator)
        coordinator.start()
    }
}
