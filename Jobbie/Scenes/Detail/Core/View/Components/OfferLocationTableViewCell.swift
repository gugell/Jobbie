//
//  OfferLocationTableViewCell.swift
//  Jobbie
//
//  Created by Ilia Gutu on 30.01.2022.
//

import UIKit
import CoreLocation
import MapKit

final class OfferLocationTableViewCell: UITableViewCell, Reusable, BindableType {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = Colors.black()

        return label
    }()

    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.setTitle(L10n.Offer.Location.open, for: .normal)
        button.setTitleColor(Colors.red(), for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = Colors.red().cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

        return button
    }()

    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = Colors.gray()
        label.numberOfLines = 0

        return label
    }()

    private lazy var districtLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = Colors.gray()
        label.numberOfLines = 0
        label.textAlignment = .right

        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = Colors.gray()
        label.numberOfLines = 0

        return label
    }()

    var viewModel: OfferLocationCellViewModel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        selectionStyle = .none

        titleLabel.add(to: contentView)
            .top(to: \.topAnchor, constant: 20)
            .leading(to: \.leadingAnchor, constant: 10)

        actionButton.add(to: contentView)
            .centerY(to: \.centerYAnchor, of: titleLabel)
            .leading(to: \.trailingAnchor, of: titleLabel, constant: 10)
            .width(150)
            .trailing(to: \.trailingAnchor, constant: 10)

        cityLabel.add(to: contentView)
            .top(to: \.bottomAnchor, of: titleLabel, constant: 20)
            .leading(to: \.leadingAnchor, constant: 10)

        districtLabel.add(to: contentView)
            .centerY(to: \.centerYAnchor, of: cityLabel)
            .leading(to: \.trailingAnchor, of: cityLabel, constant: 10)
            .trailing(to: \.trailingAnchor, constant: 10)

        descriptionLabel.add(to: contentView)
            .top(to: \.bottomAnchor, of: cityLabel, constant: 10)
            .leading(to: \.leadingAnchor, constant: 10)
            .trailing(to: \.trailingAnchor, constant: 10)
            .bottom(to: \.bottomAnchor, constant: 20)

        actionButton.addTarget(self, action: #selector(didTapMapButton), for: .touchUpInside)
    }

    @objc func didTapMapButton() {
        let coordinates = CLLocationCoordinate2DMake(viewModel.coordinates.latitude, viewModel.coordinates.longitude)
        let regionDistance = CLLocationDistance(10000)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinates, addressDictionary: nil))
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        mapItem.name = viewModel.formattedAddress
        let launchOptions = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]

        mapItem.openInMaps(launchOptions: launchOptions)
    }

    func bindViewModel() {
        titleLabel.text = L10n.Offer.location
        cityLabel.text = viewModel.cityName
        districtLabel.text = viewModel.districtName
        descriptionLabel.text = viewModel.formattedAddress
    }
}

struct OfferLocationCellViewModel {
    let cityName: String?
    let districtName: String?
    let formattedAddress: String
    let coordinates: Coordinate
}
