//
//  LookupServiceResponse.swift
//  Jobbie
//
//  Created by Ilia Gutu on 28.01.2022.
//

import Foundation

struct LookupServiceResponse: Codable {
    let offers: [Offer]
    let offset: Int
    let total: Int
    let max: Int
    let newestTimestamp: Double
}
