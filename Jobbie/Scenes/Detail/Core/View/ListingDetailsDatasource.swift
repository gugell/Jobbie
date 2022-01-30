//
//  ListingDetailsDatasource.swift
//  Jobbie
//
//  Created by Ilia Gutu on 29.01.2022.
//

import UIKit

enum ListingDetailsItem: Hashable {
    case description(title: String, totalEarn: String, hourlyEarn: String)
    case text(description: String)
    case location(cityName: String?, districtName: String?, formattedAddress: String, coordinates: Coordinate)
}

final class ListingDetailsTableDatasource: UITableViewDiffableDataSource<Int, ListingDetailsItem> {

    init(tableView: UITableView) {
        tableView.register(cellType: TextInfoTableViewCell.self)
        tableView.register(cellType: OfferLocationTableViewCell.self)
        tableView.register(cellType: OfferDescriptionTableViewCell.self)
        tableView.register(cellType: OfferInfoTableViewCell.self)

        super.init(tableView: tableView) { (collectionView, indexPath, item) -> UITableViewCell? in
            switch item {
            case .location(let cityName, let districtName, let formattedAddress, let coordinates):
                var cell = collectionView.dequeueReusableCell(for: indexPath, cellType: OfferLocationTableViewCell.self)
                cell.bind(to: .init(cityName: cityName,
                                    districtName: districtName,
                                    formattedAddress: formattedAddress,
                                    coordinates: coordinates))

                return cell
            case .description(let title, let totalEarn, let hourlyEarn):
                var cell = collectionView.dequeueReusableCell(for: indexPath,
                                                                 cellType: OfferDescriptionTableViewCell.self)
                cell.bind(to: .init(title: title, totalEarn: totalEarn, hourlyEarn: hourlyEarn))

                return cell

            case .text(let description):
                var cell = collectionView.dequeueReusableCell(for: indexPath, cellType: TextInfoTableViewCell.self)
                cell.bind(to: .init(title: L10n.Offer.description, text: description))

                return cell
            }
        }
    }
}
