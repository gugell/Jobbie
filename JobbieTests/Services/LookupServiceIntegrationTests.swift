//
//  LookupServiceTests.swift
//  JobbieTests
//
//  Created by Ilia Gutu on 28.01.2022.
//

import XCTest
@testable import Jobbie

final class LookupServiceIntegrationTests: XCTestCase {

    var service: LookupService!

    override func setUp() {
        super.setUp()

        service = LookupServiceImpl(requestDispatcher: NetworkRequestDispatcher(session: URLSession.shared, tokenClosure: { AppEnvironment.userSession.accessToken }))
    }

    func test_fetchOffers_whenNoAuthTokenIsProvided_shouldFail() {
        // GIVEN
        let expectation = self.expectation(description: "lookupCall")
        var error: Error?

        // WHEN
        service.fetchOffers(query: .init(offset: nil)) { result in
            switch result {
            case .success:
                XCTFail("Should fail because of the auth limitations")
            case .failure(let failure):
                error = failure
            }
            expectation.fulfill()
        }

        // THEN
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(error as! Failure, Failure.badStatusCode(401))
    }
}
