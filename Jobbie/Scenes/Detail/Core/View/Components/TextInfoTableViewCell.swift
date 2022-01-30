//
//  TextInfoTableViewCell.swift
//  Jobbie
//
//  Created by Ilia Gutu on 29.01.2022.
//

import UIKit

final class TextInfoTableViewCell: UITableViewCell, Reusable, BindableType {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)

        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0

        return label
    }()

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

        descriptionLabel.add(to: self)
            .top(to: \.bottomAnchor, of: titleLabel, constant: 10)
            .leading(to: \.leadingAnchor, constant: 10)
            .trailing(to: \.trailingAnchor, constant: 10)
            .bottom(to: \.bottomAnchor, constant: 20)
    }

    func bindViewModel() {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.text
    }
}

struct TextInfoCellViewModel {
    let title: String
    let text: String
}
