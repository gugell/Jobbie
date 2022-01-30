//
//  SingleShiftCell.swift
//  Zenjob iOS Challenge
//
//  Created by Milos Milakovic on 22.09.20.
//  Copyright © 2020 Zenjob. All rights reserved.
//

import UIKit

final class SingleShiftCell: UICollectionViewCell, Reusable, BindableType {

    // MARK: - Properties
    var viewModel: OfferCollectionViewCellViewModel!

    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        return view
    }()

    let generalView: GeneralView = {
        let view = GeneralView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()

    let locationView: LocationView = {
        let view = LocationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let shiftsView: SingleShiftView = {
        let view = SingleShiftView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let detailView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()

    private let line: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.880, green: 0.880, blue: 0.880, alpha: 1.00)
        return view
    }()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    private func setupUI() {
        contentView.addSubview(cardView)
        cardView.addSubview(generalView)
        cardView.addSubview(detailView)
        cardView.addSubview(line)
        detailView.addSubview(locationView)
        detailView.addSubview(shiftsView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            cardView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            cardView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            cardView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            generalView.leftAnchor.constraint(equalTo: cardView.leftAnchor),
            generalView.rightAnchor.constraint(equalTo: cardView.rightAnchor),
            generalView.topAnchor.constraint(equalTo: cardView.topAnchor),
            generalView.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 3/5),

            detailView.leftAnchor.constraint(equalTo: cardView.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: cardView.rightAnchor),
            detailView.topAnchor.constraint(equalTo: generalView.bottomAnchor),
            detailView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),

            locationView.leftAnchor.constraint(equalTo: detailView.leftAnchor),
            locationView.rightAnchor.constraint(equalTo: detailView.rightAnchor),
            locationView.topAnchor.constraint(equalTo: detailView.topAnchor),
            locationView.bottomAnchor.constraint(equalTo: detailView.centerYAnchor),

            shiftsView.leftAnchor.constraint(equalTo: detailView.leftAnchor),
            shiftsView.rightAnchor.constraint(equalTo: detailView.rightAnchor),
            shiftsView.bottomAnchor.constraint(equalTo: detailView.bottomAnchor),
            shiftsView.topAnchor.constraint(equalTo: detailView.centerYAnchor),

            line.leftAnchor.constraint(equalTo: detailView.leftAnchor, constant: 20),
            line.rightAnchor.constraint(equalTo: detailView.rightAnchor, constant: -20),
            line.centerYAnchor.constraint(equalTo: detailView.centerYAnchor),
            line.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    func bindViewModel() {
        generalView.populate(offer: viewModel.item)
        locationView.populate(location: viewModel.item.location)
        shiftsView.populate(shifts: viewModel.item.shifts)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        generalView.prepareForReuse()
        locationView.prepareForReuse()
        shiftsView.prepareForReuse()
    }

}
