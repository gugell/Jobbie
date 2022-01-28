//
//  LookupQuery.swift
//  Jobbie
//
//  Created by Ilia Gutu on 28.01.2022.
//

import Foundation

struct LookupQuery {
    let offset: Int?

    init(offset: Int? = nil) {
        self.offset = offset
    }
}
