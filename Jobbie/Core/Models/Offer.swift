//
//  Offer.swift
//  Zenjob iOS Challenge
//
//  Created by Milos Milakovic on 22.09.20.
//  Copyright © 2020 Zenjob. All rights reserved.
//

import Foundation

struct Offer: Codable {
  var id: String
  var jobMatchUuid: String
  var jobCategoryKey: String
  var title: String
  var description: String
  var instructions: String
  var companyName: String
  var companyLogoUrl: String
  var minutesSum: String
  var hourSum: String?
  var earningTotal: String
  var earningHourly: String
  var location: Location
  var breakTypes: [BreakType]
  var shifts: [Shift]
  var pricingTables: [PricingTable]
  var offerCategory: String
}
