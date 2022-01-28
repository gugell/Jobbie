//
//  MockLookupService.swift
//  JobbieTests
//
//  Created by Ilia Gutu on 28.01.2022.
//

import Foundation
@testable import Jobbie

final class MockLookupService: LookupService {

    var responseStub: Result<LookupServiceResponse, Failure> = .failure(.badResponse)

    func fetchOffers(query: LookupQuery, completionHandler: @escaping (Result<LookupServiceResponse, Failure>) -> Void) {
        completionHandler(responseStub)
    }
}

extension LookupServiceResponse {
    static func mocked(offers: [Offer] = [],
                       offset: Int = 0,
                       total: Int = 0,
                       max: Int = 0,
                       newestTimestamp: Double = 0) -> LookupServiceResponse {
        return LookupServiceResponse(offers: offers,
                                     offset: offset,
                                     total: total,
                                     max: max,
                                     newestTimestamp: newestTimestamp)
    }
}
