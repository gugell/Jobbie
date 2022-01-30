//
//  FoundationExtensions.swift
//  Jobbie
//
//  Created by Ilia Gutu on 30.01.2022.
//

import Foundation

extension Date {
    var day: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "EE"
        return formatter.string(from: self)
    }

    func toString(format: String = "EE. dd.MM") -> String {
      let formatter = DateFormatter()
      formatter.dateStyle = .short
      formatter.dateFormat = format
      return formatter.string(from: self)
    }

    func timeIn24HourFormat() -> String {
      let formatter = DateFormatter()
      formatter.dateStyle = .none
      formatter.dateFormat = "HH:mm"
      return formatter.string(from: self)
    }
}
