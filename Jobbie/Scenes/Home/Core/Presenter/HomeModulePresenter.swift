//
//  HomeModulePresenter.swift
//  Jobbie
//
//  Created by Ilia Gutu on 29.01.2022.
//

import Foundation

final class HomeModulePresenter: HomeModuleViewOutput, HomeModuleInteractorOutput {

    weak var view: HomeModuleViewInput!
    var interactor: HomeModuleInteractorInput

    private var offers: [Offer] = []
    /// Router
    var router: HomeModuleRouterInput

    /// Initialization
    ///
    /// - Parameters:
    ///   - view: View
    ///   - interactor: Interactor
    ///   - router: Router
    init(view: HomeModuleViewInput,
         interactor: HomeModuleInteractorInput,
         router: HomeModuleRouterInput) {
      self.view = view
      self.interactor = interactor
      self.router = router
    }

    func viewDidLoad() {
        view?.setupInitialState()
        reloadData()
    }

    func didSelectItem(at indexPath: IndexPath) {
        router.showOfferDetails(offers[indexPath.item])
    }

    func interactorDidFinishLoading(_ offers: [Offer]) {
        view?.endRefreshing()
        let viewModels = offers.map { OfferCollectionViewCellViewModel(offer: $0) }
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModels)
        self.offers = offers
        view?.applySnapshot(snapshot: snapshot)
    }

    func interactorDidFailWithError(_ error: String) {
        onMain {
            self.view?.endRefreshing()
            self.view?.showEmptyView()
            self.router.showErrorAlert(error, onRetry: self.reloadData)
        }

    }

    func reloadData() {
        view?.showHUD()
        view?.hideEmptyView()
        interactor.reloadData()
    }
}
