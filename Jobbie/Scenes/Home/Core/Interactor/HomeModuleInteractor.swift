//
//  HomeModuleInteractor.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import Foundation

/// Modules interactor input
protocol HomeModuleInteractorInput: AnyObject {
  /// Reload listings from server
  func reloadData()
}

/// Modules interactor output
protocol HomeModuleInteractorOutput: AnyObject {
  /// Notifies that interactor finished loading listings
    func interactorDidFinishLoading(_ offers: [Offer])
    func interactorDidFailWithError(_ error: String)
}

final class HomeModuleInteractor: HomeModuleInteractorInput {

    weak var output: HomeModuleInteractorOutput!
    private let lookupService: LookupService

    init(lookupService: LookupService) {
        self.lookupService = lookupService
    }

    func reloadData() {
        lookupService.fetchOffers(query: .init(offset: nil)) { [weak self] result in

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                switch result {
                case .success(let response):
                    self?.output?.interactorDidFinishLoading(response.offers)
                case .failure(let error):
                    self?.output?.interactorDidFailWithError(error.localizedDescription)
                }
            }
        }
    }
}