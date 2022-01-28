//
//  Credentials.swift
//  Jobbie
//
//  Created by Ilia Gutu on 28.01.2022.
//

import Foundation

struct Credentials {
    let username: String
    let password: String

    public static let `default` = Credentials(username: "ios.challenge@zenjob.com", password: "12345678")
}
