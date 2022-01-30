//
//  MultipleShiftsView.swift
//  Zenjob iOS Challenge
//
//  Created by Milos Milakovic on 22.09.20.
//  Copyright © 2020 Zenjob. All rights reserved.
//

import UIKit

final class MultipleShiftsView: UIView {

  let startDateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = UIColor(red: 0.314, green: 0.325, blue: 0.365, alpha: 1.0)
    label.font = UIFont.boldSystemFont(ofSize: 14)
    return label
  }()

  let startTimeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = UIColor(red: 0.631, green: 0.651, blue: 0.690, alpha: 1.00)
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textAlignment = .right
    return label
  }()

  let startTimeIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  let endDateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = UIColor(red: 0.314, green: 0.325, blue: 0.365, alpha: 1.0)
    label.font = UIFont.boldSystemFont(ofSize: 14)
    return label
  }()

  let endTimeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = UIColor(red: 0.631, green: 0.651, blue: 0.690, alpha: 1.00)
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textAlignment = .right
    return label
  }()

  let endTimeIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  let shiftsLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = UIColor(red: 0.631, green: 0.651, blue: 0.690, alpha: 1.00)
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textAlignment = .right
    return label
  }()

  private let line: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor(red: 0.290, green: 0.149, blue: 0.592, alpha: 1.0)
    return view
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    self.layer.masksToBounds = true
    self.addSubview(startDateLabel)
    self.addSubview(startTimeLabel)
    self.addSubview(startTimeIcon)
    self.addSubview(endDateLabel)
    self.addSubview(endTimeLabel)
    self.addSubview(endTimeIcon)
    self.addSubview(shiftsLabel)
    self.addSubview(line)

  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    NSLayoutConstraint.activate([
      startTimeIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
      startTimeIcon.centerYAnchor.constraint(equalTo: startTimeLabel.centerYAnchor),
      startTimeIcon.heightAnchor.constraint(equalToConstant: 15),
      startTimeIcon.widthAnchor.constraint(equalTo: startTimeIcon.heightAnchor),

      startTimeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
      startTimeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
      startTimeLabel.bottomAnchor.constraint(equalTo: shiftsLabel.topAnchor, constant: -10),

      startDateLabel.leftAnchor.constraint(equalTo: startTimeIcon.rightAnchor, constant: 10),
      startDateLabel.rightAnchor.constraint(equalTo: startTimeLabel.leftAnchor, constant: -10),
      startDateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),

      shiftsLabel.leftAnchor.constraint(equalTo: startTimeIcon.rightAnchor, constant: 10),
      shiftsLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
      shiftsLabel.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor, constant: 10),
      shiftsLabel.bottomAnchor.constraint(equalTo: endDateLabel.topAnchor, constant: -10),

      line.centerXAnchor.constraint(equalTo: startTimeIcon.centerXAnchor),
      line.widthAnchor.constraint(equalToConstant: 1),
      line.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor, constant: 4),
      line.bottomAnchor.constraint(equalTo: endDateLabel.topAnchor, constant: -4),

      endTimeIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
      endTimeIcon.centerYAnchor.constraint(equalTo: endTimeLabel.centerYAnchor),
      endTimeIcon.heightAnchor.constraint(equalToConstant: 15),
      endTimeIcon.widthAnchor.constraint(equalTo: endTimeIcon.heightAnchor),

      endTimeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
      endTimeLabel.topAnchor.constraint(equalTo: shiftsLabel.bottomAnchor, constant: 10),
      endTimeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),

      endDateLabel.leftAnchor.constraint(equalTo: endTimeIcon.rightAnchor, constant: 10),
      endDateLabel.rightAnchor.constraint(equalTo: endTimeLabel.leftAnchor, constant: -10),
      endDateLabel.topAnchor.constraint(equalTo: shiftsLabel.bottomAnchor, constant: 10),
      endDateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
      ])
  }

  func populate(shifts: [Shift]) {
    startDateLabel.text = shifts.first?.beginDate.toString()
    endDateLabel.text = shifts.first?.beginDate.toString()

    if let beginDate = shifts.first?.beginDate, let endDate = shifts.first?.endDate {
      startTimeLabel.text = "\(beginDate.timeIn24HourFormat()) - \(endDate.timeIn24HourFormat())"
    }

    if let beginDate = shifts.last?.beginDate, let endDate = shifts.last?.endDate {
      endTimeLabel.text = "\(beginDate.timeIn24HourFormat()) - \(endDate.timeIn24HourFormat())"
    }

    startTimeIcon.image = UIImage(named: "clock")
    endTimeIcon.image = UIImage(named: "clock")

    shiftsLabel.text = shifts.count - 2 <= 0 ? "" : "+\(shifts.count - 2) Shifts"
  }

  func prepareForReuse() {
    startDateLabel.text = nil
    startTimeLabel.text = nil
    endDateLabel.text = nil
    endTimeLabel.text = nil
    shiftsLabel.text = nil
  }

}
