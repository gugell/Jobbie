//
//  TextInfoTableViewCell.swift
//  Jobbie
//
//  Created by Ilia Gutu on 29.01.2022.
//

import UIKit

final class TextInfoTableViewCell: UITableViewCell, Reusable, BindableType {

    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let dateLabel = UILabel()

    var viewModel: TextInfoCellViewModel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        titleLabel.add(to: self)
            .top(to: \.topAnchor, constant: 20)
            .leading(to: \.leadingAnchor, constant: 10)

        priceLabel.add(to: self)
            .leading(to: \.trailingAnchor, of: titleLabel, constant: 20)
            .trailing(to: \.trailingAnchor, constant: 10)
            .centerY(to: \.centerYAnchor, of: titleLabel)

        dateLabel.add(to: self)
            .top(to: \.bottomAnchor, of: titleLabel, constant: 10)
            .leading(to: \.leadingAnchor, constant: 10)
            .trailing(to: \.trailingAnchor, constant: 10)
            .bottom(to: \.bottomAnchor, constant: 20)
//
//        titleLabel.apply(style: TextStyles.title)
//        dateLabel.apply(style: TextStyles.subtitle)
//        priceLabel.apply(style: TextStyles.attribute)
    }

    func bindViewModel() {
        titleLabel.text = viewModel.name
        priceLabel.text = viewModel.price
        dateLabel.text = viewModel.createdAt
    }
}

struct TextInfoCellViewModel {
    let name: String
    let price: String
    let createdAt: String
}
