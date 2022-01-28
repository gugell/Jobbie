//
//  AuthServicesIntegrationTests.swift
//  JobbieTests
//
//  Created by Ilia Gutu on 28.01.2022.
//
import XCTest
@testable import Jobbie

final class AuthServicesIntegrationTests: XCTestCase {

    var service: AuthServicesImpl!

    override func setUp() {
        super.setUp()

        service = AuthServicesImpl(requestDispatcher: NetworkRequestDispatcher(session: URLSession.shared))
    }

    func test_signIn_whenCorrectCredentialsAreProvided_shouldSucceed() {
        //GIVEN
        let expectation = self.expectation(description: "authCall")
        var user: User?

        //WHEN
        service.signIn(with: .default) { result in
            switch result {
            case .success(let response):
                user = response
            case .failure:
                XCTFail("Should pass api checks")
            }
            expectation.fulfill()
        }

        //THEN
        waitForExpectations(timeout: 10, handler: nil)
//        XCTAssertEqual(error as! Failure, Failure.badStatusCode(401))
        XCTAssertNotNil(user)
    }

    func test_signIn_whenWrongCredentialsAreProvided_shouldSucceed() {
        //GIVEN
        let expectation = self.expectation(description: "authCall")
        var error: Error?

        //WHEN
        service.signIn(with: .init(username: "goodboy", password: "his_password")) { result in
            switch result {
            case .success:
                XCTFail("Should fail")
            case .failure(let failure):
                error = failure
            }
            expectation.fulfill()
        }

        //THEN
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(error as! Failure, Failure.badStatusCode(401))
    }
}

