//
//  HomeModule.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import UIKit

enum HomeModuleAssembly {
    static func assembly(coordinator: HomeFlowCoordinatorInput) -> Presentable {
        let viewController =  HomeViewController()
        let interactor = HomeModuleInteractor(lookupService: AppEnvironment.lookupService)
        let router = HomeModuleRouter(coordinator: coordinator)
        let presenter = HomeModulePresenter(view: viewController,
                                      interactor: interactor,
                                      router: router)

        viewController.output = presenter
        interactor.output = presenter

        return viewController
    }
}
