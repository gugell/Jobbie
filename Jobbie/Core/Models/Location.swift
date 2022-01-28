//
//  Location.swift
//  Zenjob iOS Challenge
//
//  Created by Milos Milakovic on 22.09.20.
//  Copyright © 2020 Zenjob. All rights reserved.
//

import Foundation

struct Location: Codable {

  var city: String?
  var district: String?
  var locationDisplayName: String
  var locationLatitude: Double?
  var locationLongitude: Double?
  var locationName: String
  var locationSearchString: String?
  var postalCode: String?
  var street: String?
  var streetNumber: String?
  var supplementary: String?

}
