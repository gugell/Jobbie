//
//  AuthModuleBuilder.swift
//  Jobbie
//
//  Created by Ilia Gutu on 28.01.2022.
//

import Foundation

enum AuthModuleAssembly {
    static func assembly(coordinator: AuthFlowCoordinatorInput) -> Presentable {
        let viewController =  AuthViewController()
        let interactor = AuthModuleInteractor(authService: AppEnvironment.authService)
        let router = AuthModuleRouter(coordinator: coordinator)
        let presenter = AuthModulePresenter(view: viewController,
                                      interactor: interactor,
                                      router: router)

        viewController.output = presenter
        interactor.output = presenter

        return viewController
    }
}
