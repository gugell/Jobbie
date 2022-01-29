//
//  HomeViewController.swift
//  Jobbie
//
//  Created by Ilia Gutu on 29.01.2022.
//

import UIKit

typealias Snapshot = NSDiffableDataSourceSnapshot<Int, OfferCollectionViewCellViewModel>

/// Modules view input
protocol HomeModuleViewInput: Presentable, HUDPresentable {
  /// Setup initial state
  func setupInitialState()
    /// Stops refreshing and hide loader
    func endRefreshing()
  /// Apply snapshot of data to display in collection
  ///
  /// - Parameters:
  ///   - snapshot: Snapshot of data to apply
  func applySnapshot(snapshot: Snapshot)
  /// Shows empty view if no data is available
  func showEmptyView()
  /// Hides empty view if no data is available
  func hideEmptyView()
}

/// Modules view output
protocol HomeModuleViewOutput: AnyObject {
  /// Notifies that view is ready
  func viewDidLoad()
  /// Notifies  to reload data if needed
  func reloadData()
    /// Pass indexPath of selected item
    ///
    /// - Parameters:
    ///   - indexPath: IndexPath of selected item
  func didSelectItem(at indexPath: IndexPath)
}

final class HomeViewController: UICollectionViewController, HUDPresentable {

    var output: HomeModuleViewOutput!

    private let refreshControl = UIRefreshControl()
    private var dataSource: ListingsCollectionDatasource!

    private var inlineLayout: UICollectionViewLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }()

    init() {
        super.init(collectionViewLayout: inlineLayout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        configureDataSource()
        output.viewDidLoad()
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.didSelectItem(at: indexPath)
    }

    private func configureDataSource() {
        dataSource = ListingsCollectionDatasource(collectionView: collectionView)
    }

    private func setupUI() {
        navigationItem.title = L10n.Home.title
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: L10n.Offers.fetching)
        collectionView.refreshControl = refreshControl
    }

    @objc func reloadData() {
        output.viewDidLoad()
    }

    func endRefreshing() {
        refreshControl.endRefreshing()
        hideHUD()
    }
}

extension HomeViewController: HomeModuleViewInput {
    func applySnapshot(snapshot: Snapshot) {
        dataSource.apply(snapshot)
        snapshot.numberOfItems == 0 ? showEmptyView() : hideEmptyView()
    }

    func showEmptyView() {
        var emptyView = EmptyView()
        collectionView.backgroundView = emptyView
        emptyView.bind(to: .init(text: L10n.Home.emptyFeed))
    }

    func hideEmptyView() {
        collectionView.backgroundView = nil
    }

    func setupInitialState() {
        showEmptyView()
    }
}
