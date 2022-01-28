//
//  EmptyView.swift
//  Classie
//
//  Created by Ilia Gutu on 13.01.2022.
//

import UIKit

final class EmptyView: UIView, BindableType {

    var viewModel: EmptyViewModel!
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    private func setupUI() {
        titleLabel.add(to: self)
            .pinToEdges()

        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bindViewModel() {
        titleLabel.text = viewModel.text
    }
}

struct EmptyViewModel {
    let text: String
}
