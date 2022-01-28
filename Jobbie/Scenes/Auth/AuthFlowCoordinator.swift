//
//  AuthFlowCoordinator.swift
//  Jobbie
//
//  Created by Ilia Gutu on 28.01.2022.
//

import Foundation

protocol AuthFlowCoordinatorInput {
    func showAlert(_ alert: Alert)
    func didFinishFlow()
}

final class AuthFlowCoordinator: BaseCoordinator {

    private let wireframe: Wireframe
    var whenDone: EmptyAction?

    init(wireframe: Wireframe) {
        self.wireframe = wireframe
    }

    override func start() {
        runInitialFlow()
    }

    private func runInitialFlow() {
        let homeModule = AuthModuleAssembly.assembly(coordinator: self)
        wireframe.setRootModule(homeModule)
    }
}

extension AuthFlowCoordinator: AuthFlowCoordinatorInput {
    func showAlert(_ alert: Alert) {
        wireframe.present(alert)
    }

    func didFinishFlow() { whenDone?() }
}

