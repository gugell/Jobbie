//
//  OfferCollectionViewCellViewModel.swift
//  Jobbie
//
//  Created by Ilia Gutu on 30.01.2022.
//

import Foundation

struct OfferCollectionViewCellViewModel: Hashable {
    let name: String
    let earningHourly: String
    let uid: String
    let offerCategory: String
    let shiftType: ShiftType
    let item: Offer

    enum ShiftType {
        case single
        case multiple
    }

    static func == (lhs: OfferCollectionViewCellViewModel, rhs: OfferCollectionViewCellViewModel) -> Bool {
        return lhs.uid == rhs.uid && lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
        hasher.combine(name)
        hasher.combine(offerCategory)
    }
}

 extension OfferCollectionViewCellViewModel {
    init(offer: Offer) {
        self.name = offer.title
        self.uid = offer.id
        self.earningHourly = offer.earningHourly
        self.offerCategory = offer.offerCategory
        self.shiftType = offer.shifts.count > 1 ? .multiple : .single
        self.item = offer
    }
 }
