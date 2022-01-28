//
//  ListingCollectionViewCell.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import UIKit

final class ListingCollectionViewCell: UICollectionViewCell, Reusable, BindableType {
    var viewModel: OfferCollectionViewCellViewModel!

    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let dateLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    private func setupUI() {
        titleLabel.add(to: self)
            .top(to: \.topAnchor, of: self, constant: 20)
            .leading(to: \.leadingAnchor, constant: 10)

        priceLabel.add(to: self)
            .leading(to: \.trailingAnchor, of: titleLabel, constant: 20)
            .trailing(to: \.trailingAnchor, constant: 10)
            //.centerY(to: \.centerYAnchor, of: titleLabel)

        dateLabel.add(to: self)
            .top(to: \.bottomAnchor, of: titleLabel, constant: 10)
            .leading(to: \.leadingAnchor, constant: 10)
            .trailing(to: \.trailingAnchor, constant: 10)
            .bottom(to: \.bottomAnchor, constant: 20)
//        titleLabel.apply(style: TextStyles.title)
//        dateLabel.apply(style: TextStyles.subtitle)
//        priceLabel.apply(style: TextStyles.attribute)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bindViewModel() {
        titleLabel.text = viewModel.name
        priceLabel.text = viewModel.price
        dateLabel.text = viewModel.createdAt
//        let images = viewModel.images + Picsum.Generator.randomImages()
//
//        // TODO: - Remove this logic once multiple images will be available for any of the items
//        let mocksImages = images.map { CustomImageSource(url: $0, placeholder: Assets.defaultPlaceholder())}
//        imageCarouselView.setImageInputs(mocksImages)
    }
}

struct OfferCollectionViewCellViewModel: Hashable {
    let name: String
    let price: String
    let createdAt: String
    let uid: String
    let images: [URL]
}

//extension OfferCollectionViewCellViewModel {
//    init(listing: Offer) {
////        self.name = listing.name
////        self.uid = listing.uid
////        self.price = listing.price
////        self.images = listing.images.map { $0.url }
////        self.createdAt = listing.createdAt
//    }
//}
