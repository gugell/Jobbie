//
//  OfferShiftsTableViewCell.swift
//  Jobbie
//
//  Created by Ilia Gutu on 30.01.2022.
//

import UIKit

final class OfferShiftsTableViewCell: UITableViewCell, BindableType, Reusable {
    private var datasource: UICollectionViewDiffableDataSource<Int, ShiftCellViewModel>!
    var viewModel: OfferShiftsCellViewModel!

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())

        return collectionView
    }()

    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension:
                                                                    .fractionalWidth(1.0),
                                                            heightDimension: .fractionalHeight(1.0)))

        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize,
                                                     subitem: item,
                                                     count: 1)
        group.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

        return UICollectionViewCompositionalLayout(section: section)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
        configureDataSource()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        selectionStyle = .none

        collectionView
            .add(to: contentView)
            .height(140)
            .pinToEdges()
            .leading(to: \.leadingAnchor, constant: 20)
    }

    func configureDataSource() {
        datasource = UICollectionViewDiffableDataSource(collectionView: collectionView,
                                                        cellProvider: { (cv, idx, item) -> UICollectionViewCell? in
            var cell = cv.dequeueReusableCell(for: idx, cellType: ShiftCollectionViewCell.self)

            cell.bind(to: item)
            return cell
        })

        collectionView.register(cellType: ShiftCollectionViewCell.self)
    }

    func bindViewModel() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, ShiftCellViewModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.shifts)
        datasource.apply(snapshot)
    }
}

struct OfferShiftsCellViewModel: Hashable {
    let shifts: [ShiftCellViewModel]
}
