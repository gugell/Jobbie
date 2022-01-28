//
//  LookupServices.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import Combine
import Foundation

protocol LookupService {
    func fetchOffers(query: LookupQuery, completionHandler: @escaping  (Result<LookupServiceResponse, Failure>) -> Void)
}

final class LookupServiceImpl: LookupService {
    private let requestDispatcher: RequestDispatcher

    init(requestDispatcher: RequestDispatcher) {
        self.requestDispatcher = requestDispatcher
    }

    func fetchOffers(query: LookupQuery, completionHandler: @escaping (Result<LookupServiceResponse, Failure>) -> Void) {
        requestDispatcher.dataTask(with: OffersRequest.offers(offset: query.offset)) { result in
            switch result {
            case .success(let data):
                do {
                    let offers = try JSONResponseDecoder().mapObject(ofType: LookupServiceResponse.self,
                                                                    from: data)
                    completionHandler(.success(offers))
                } catch {
                    debugPrint("Failed to decode JSON", error.localizedDescription)
                    completionHandler(.failure(.underlying(error)))
                }
            case .failure(let error):
                completionHandler(.failure(Failure(error: error)))
            }
        }?.resume()
    }
}
