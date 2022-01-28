//
//  User.swift
//  Zenjob iOS Challenge
//
//  Created by Milos Milakovic on 22.09.20.
//  Copyright © 2020 Zenjob. All rights reserved.
//

import Foundation

struct User: Codable {

  var username: String
  var accessToken: String
  var refreshToken: String
  var expiry: Int

  enum CodingKeys: String, CodingKey {
    case username
    case accessToken = "access_token"
    case refreshToken = "refresh_token"
    case expiry = "expires_in"
  }

}
