//
//  OfferDescriptionTableViewCell.swift
//  Jobbie
//
//  Created by Ilia Gutu on 30.01.2022.
//

import UIKit

final class OfferDescriptionTableViewCell: UITableViewCell, Reusable, BindableType {

    var viewModel: OfferDescriptionCellViewModel!

    private lazy var generalView: GeneralView = {
        let view = GeneralView()

        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        generalView.add(to: self)
            .height(200)
            .pinToEdges()
    }

    func bindViewModel() {
        generalView.populate(title: viewModel.title,
                             totalEarn: viewModel.totalEarn,
                             hourlyEarn: viewModel.hourlyEarn)
    }
}

struct OfferDescriptionCellViewModel {
    let title, totalEarn, hourlyEarn: String
}
