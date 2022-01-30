//
//  MockHomeInteractorOutput.swift
//  JobbieTests
//
//  Created by Ilia Gutu on 30.01.2022.
//

import Foundation
@testable import Jobbie

final class MockHomeInteractorOutput: HomeModuleInteractorOutput {

    let interactorDidFinishLoadingFuncCheck = FuncCheck<[Offer]>()
    func interactorDidFinishLoading(_ offers: [Offer]) {
        interactorDidFinishLoadingFuncCheck.call(offers)
    }

    let interactorDidFailWithErrorFuncCheck = FuncCheck<String>()
    func interactorDidFailWithError(_ error: String) {
        interactorDidFailWithErrorFuncCheck.call(error)
    }
}
