//
//  ListingsCollectionDatasource.swift
//  Jobbie
//
//  Created by Ilia Gutu on 29.01.2022.
//

import UIKit

final class ListingsCollectionDatasource: UICollectionViewDiffableDataSource<Int, OfferCollectionViewCellViewModel> {

    init(collectionView: UICollectionView) {
        collectionView.register(cellType: SingleShiftCell.self)
        collectionView.register(cellType: MultipleShiftsCell.self)

        super.init(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in

            switch item.shiftType {
            case .single:
                var cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SingleShiftCell.self)
                cell.bind(to: item)

                return cell
            case .multiple:
                var cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MultipleShiftsCell.self)
                cell.bind(to: item)

                return cell
            }
        }
    }
}
