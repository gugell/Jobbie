//
//  ListingDetailsModule.swift
//  Jobbie
//
//  Created by Ilia Gutu on 29.01.2022.
//

import UIKit

enum ListingDetailsModuleAssembly {
    static func assembly(offer: Offer,
                         coordinator: DetailsFlowCoordinatorInput) -> Presentable {
        let viewController = ListingDetailsViewController()
        let router = ListingDetailsModuleRouter(coordinator: coordinator)
        let presenter = ListingDetailsModulePresenter(offer: offer,
                                                      view: viewController,
                                      router: router)

        viewController.output = presenter

        return viewController
    }
}
