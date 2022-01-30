//
//  OfferInfoTableViewCell.swift
//  Jobbie
//
//  Created by Ilia Gutu on 30.01.2022.
//

import UIKit

final class OfferInfoTableViewCell: UITableViewCell, Reusable, BindableType {

    var viewModel: OfferInfoCellViewModel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindViewModel() {

    }
}

struct OfferInfoCellViewModel {

}
