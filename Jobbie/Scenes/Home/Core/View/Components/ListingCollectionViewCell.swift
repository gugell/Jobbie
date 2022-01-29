//
//  ListingCollectionViewCell.swift
//  Jobbie
//
//  Created by Ilia Gutu on 29.01.2022.
//

import UIKit

final class ListingCollectionViewCell: UICollectionViewCell, Reusable, BindableType {
    var viewModel: OfferCollectionViewCellViewModel!

    private let titleLabel = UILabel()
    private let offerCategoryLabel = UILabel()
    private let priceLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    private func setupUI() {
        titleLabel.add(to: self)
            .top(to: \.topAnchor, of: self, constant: 20)
            .leading(to: \.leadingAnchor, constant: 10)

        offerCategoryLabel.add(to: self)
            .top(to: \.bottomAnchor, of: titleLabel, constant: 10)
            .leading(to: \.leadingAnchor, constant: 10)
            .trailing(to: \.trailingAnchor, constant: 10)
            .bottom(to: \.bottomAnchor, constant: 20)

        priceLabel.add(to: self)
            .leading(to: \.trailingAnchor, of: titleLabel, constant: 20)
            .trailing(to: \.trailingAnchor, constant: 10)
             .centerY(to: \.centerYAnchor, of: titleLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bindViewModel() {
        titleLabel.text = viewModel.name
        priceLabel.text = viewModel.earningHourly
        offerCategoryLabel.text = viewModel.offerCategory
//        let images = viewModel.images + Picsum.Generator.randomImages()
//
//        // TODO: - Remove this logic once multiple images will be available for any of the items
//        let mocksImages = images.map { CustomImageSource(url: $0, placeholder: Assets.defaultPlaceholder())}
//        imageCarouselView.setImageInputs(mocksImages)
    }
}

struct OfferCollectionViewCellViewModel: Hashable {
    let name: String
    let earningHourly: String
    let uid: String
    let offerCategory: String
}

 extension OfferCollectionViewCellViewModel {
    init(offer: Offer) {
        self.name = offer.title
        self.uid = offer.id
        self.earningHourly = offer.earningHourly
        self.offerCategory = offer.offerCategory
    }
 }
