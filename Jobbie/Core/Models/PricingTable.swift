//
//  PricingTable.swift
//  Zenjob iOS Challenge
//
//  Created by Milos Milakovic on 22.09.20.
//  Copyright © 2020 Zenjob. All rights reserved.
//

import Foundation

struct PricingTable: Codable {
  
  var isSummary: Bool
  var times: Int?
  var minutes: Int
  var name: String
  var unpaid: Bool
  var earningHourly: String
  var earningTotal: String
  
}
