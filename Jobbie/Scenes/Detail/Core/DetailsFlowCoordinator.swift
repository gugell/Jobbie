//
//  DetailsFlowCoordinator.swift
//  Jobbie
//
//  Created by Ilia Gutu on 29.01.2022.
//

import Foundation

protocol DetailsFlowCoordinatorInput {
    func dismiss()
}

final class DetailsFlowCoordinator: BaseCoordinator {

    private let wireframe: Wireframe
    private let offer: Offer

    var whenDone: EmptyAction?

    init(offer: Offer, wireframe: Wireframe) {
        self.offer = offer
        self.wireframe = wireframe
    }

    override func start() {
        runInitialFlow()
    }

    private func runInitialFlow() {
        let viewModule = ListingDetailsModuleAssembly.assembly(offer: offer,
                                                               coordinator: self)
        wireframe.presentEmbedded(viewModule)
    }
}

extension DetailsFlowCoordinator: DetailsFlowCoordinatorInput {
    func dismiss() {
        wireframe.dismissModule()
        whenDone?()
    }
}
