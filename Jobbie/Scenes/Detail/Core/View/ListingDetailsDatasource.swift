//
//  ListingDetailsDatasource.swift
//  Jobbie
//
//  Created by Ilia Gutu on 29.01.2022.
//

import UIKit

enum ListingDetailsItem: Hashable {
//    case images([URL])
    case info(title: String, price: String, createdAt: String)
}

final class ListingDetailsTableDatasource: UITableViewDiffableDataSource<Int, ListingDetailsItem> {

    init(tableView: UITableView) {
        tableView.register(cellType: TextInfoTableViewCell.self)
        super.init(tableView: tableView) { (collectionView, indexPath, item) -> UITableViewCell? in
            switch item {
//            case .images(let urls):
//                var cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ImagesCollectionViewCell.self)
//                cell.bind(to: .init(images: urls))
//
//                return cell
            case .info(let title, let price, let createdAt):
                var cell = collectionView.dequeueReusableCell(for: indexPath, cellType: TextInfoTableViewCell.self)
                cell.bind(to: .init(name: title, price: price, createdAt: createdAt))

                return cell
            }
        }
    }
}
