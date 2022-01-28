//
//  HomeFlowCoordinator.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import Foundation

protocol HomeFlowCoordinatorInput {
    func showAlert(_ alert: Alert)
    func showOfferDetails(_ offer: Offer)
}

final class HomeFlowCoordinator: BaseCoordinator {

    private let wireframe: Wireframe
    var onFinishFlow: EmptyAction?

    init(wireframe: Wireframe) {
        self.wireframe = wireframe
    }

    override func start() {
        runInitialFlow()
    }

    private func runInitialFlow() {
        let homeModule = HomeModuleAssembly.assembly(coordinator: self)
        wireframe.setRootModule(homeModule)
    }
}

extension HomeFlowCoordinator: HomeFlowCoordinatorInput {
    func showAlert(_ alert: Alert) {
        wireframe.present(alert)
    }

    func showOfferDetails(_ offer: Offer) {
//        let coordinator = DetailsFlowCoordinator(listing: listing, wireframe: wireframe)
//        coordinator.whenDone = { [weak self, weak coordinator] in
//            self?.removeDependency(coordinator)
//        }
//        addDependency(coordinator)
//        coordinator.start()
    }
}
