//
//  ListingDetailsModulePresenter.swift
//  Jobbie
//
//  Created by Ilia Gutu on 29.01.2022.
//

import Foundation

final class ListingDetailsModulePresenter: ListingDetailsModuleViewOutput {

    weak var view: ListingDetailsModuleViewInput!
    /// Router
    var router: ListingDetailsModuleRouterInput
    private let offer: Offer

    /// Initialization
    ///
    /// - Parameters:
    ///   - view: View
    ///   - router: Router
    init(offer: Offer,
         view: ListingDetailsModuleViewInput,
         router: ListingDetailsModuleRouterInput) {
      self.view = view
      self.router = router
      self.offer = offer
    }

    func viewDidLoad() {
        view?.setupInitialState(viewModel: .init(title: offer.title))
        var snapshot = ListingDetailsSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems([
            .description(title: offer.title, totalEarn: offer.earningTotal, hourlyEarn: offer.earningHourly),
            .location(cityName: offer.location.city,
                      districtName: offer.location.district,
                      formattedAddress: offer.location.locationSearchString ?? "na",
                      coordinates: .init(latitude: offer.location.locationLatitude ?? 0,
                                         longitude: offer.location.locationLongitude ?? 0)),
            .text(description: offer.description)])
        view?.applySnapshot(snapshot: snapshot)
    }

    func onCloseButtonTapped() {
        router.dismiss()
    }

    func showListingImages() {

    }
}
