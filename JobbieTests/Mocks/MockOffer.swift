//
//  MockOffer.swift
//  JobbieTests
//
//  Created by Ilia Gutu on 30.01.2022.
//

import Foundation
@testable import Jobbie

extension Offer {
    static func mocked( uid: String = UUID().uuidString, title: String = "", description: String = "") -> Offer {
        return Offer(id: uid, jobMatchUuid: uid, jobCategoryKey: "", title: title, description: description, instructions: "", companyName: "", companyLogoUrl: "", minutesSum: "",
                     hourSum: nil,
                     earningTotal: "",
                     earningHourly: "",
                     location: .mocked(),
                     breakTypes: [],
                     shifts: [], pricingTables: [],
                     offerCategory: "Mocked category")
    }
}

extension Location {
    static func mocked(city: String? = nil, district: String? = nil, locationName: String = "") -> Location {
        return Location(city: city, district: district,
                        locationDisplayName: "",
                        locationLatitude: nil,
                        locationLongitude: nil,
                        locationName: locationName,
                        locationSearchString: locationName,
                        postalCode: nil,
                        street: nil,
                        streetNumber: nil,
                        supplementary: nil)
    }
}
