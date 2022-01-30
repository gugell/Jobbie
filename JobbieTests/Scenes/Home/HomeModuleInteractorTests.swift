//
//  HomeModuleInteractorTests.swift
//  JobbieTests
//
//  Created by Ilia Gutu on 30.01.2022.
//

import XCTest
@testable import Jobbie

final class HomeModuleInteractorTests: XCTestCase {

    var interactor: HomeModuleInteractor!
    var lookupService: MockLookupService!
    var output: MockHomeInteractorOutput!

    override func setUp() {
        super.setUp()

        lookupService = MockLookupService()
        output = MockHomeInteractorOutput()
        interactor = HomeModuleInteractor(lookupService: lookupService)
        interactor.output = output
    }

    func test_reloadData_whenSucceded_shouldCallOutputWithData() {
        // GIVEN
        lookupService.responseStub = .success(.init(offers: [Offer.mocked(), Offer.mocked()],
                                                    offset: 0,
                                                    total: 2,
                                                    max: 4,
                                                    newestTimestamp: 12345678))

        // WHEN
        interactor.reloadData()

        // THEN
        XCTAssertTrue(output.interactorDidFinishLoadingFuncCheck.wasCalled)
    }

    func test_reloadData_whenFailed_shouldCallOutputWithError() {
        // GIVEN
        lookupService.responseStub = .failure(Failure.badStatusCode(404))

        // WHEN
        interactor.reloadData()

        // THEN
        XCTAssertTrue(output.interactorDidFailWithErrorFuncCheck.wasCalled)
    }
}
