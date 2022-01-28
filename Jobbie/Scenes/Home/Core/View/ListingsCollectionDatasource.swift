//
//  ListingsCollectionDatasource.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import UIKit

final class ListingsCollectionDatasource: UICollectionViewDiffableDataSource<Int, OfferCollectionViewCellViewModel> {

    init(collectionView: UICollectionView) {
        collectionView.register(cellType: ListingCollectionViewCell.self)

        super.init(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            var cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ListingCollectionViewCell.self)
            cell.bind(to: item)

            return cell
        }
    }
}
