//
//  SingleShiftView.swift
//  Zenjob iOS Challenge
//
//  Created by Milos Milakovic on 22.09.20.
//  Copyright © 2020 Zenjob. All rights reserved.
//

import UIKit

class SingleShiftView: UIView {

  let dateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = UIColor(red: 0.314, green: 0.325, blue: 0.365, alpha: 1.0)
    label.font = UIFont.boldSystemFont(ofSize: 14)
    return label
  }()

  let timeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = UIColor(red: 0.631, green: 0.651, blue: 0.690, alpha: 1.00)
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textAlignment = .right
    return label
  }()

  let timeIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    self.layer.masksToBounds = true
    self.addSubview(dateLabel)
    self.addSubview(timeLabel)
    self.addSubview(timeIcon)

  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    NSLayoutConstraint.activate([
      timeIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
      timeIcon.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor),
      timeIcon.heightAnchor.constraint(equalToConstant: 15),
      timeIcon.widthAnchor.constraint(equalTo: timeIcon.heightAnchor),

      timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
      timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
      timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),

      dateLabel.leftAnchor.constraint(equalTo: timeIcon.rightAnchor, constant: 10),
      dateLabel.rightAnchor.constraint(equalTo: timeLabel.leftAnchor, constant: -10),
      dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
      dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15)
      ])
  }

  override func layoutSublayers(of layer: CALayer) {
    super.layoutSublayers(of: layer)
    fitSizes()
  }

  func populate(shifts: [Shift]) {
    fitSizes()
    dateLabel.text = shifts.first?.beginDate.toString()

    if let beginDate = shifts.first?.beginDate, let endDate = shifts.first?.endDate {
      timeLabel.text = "\(beginDate.timeIn24HourFormat()) - \(endDate.timeIn24HourFormat())"
    }

    timeIcon.image = UIImage(named: "clock")
  }

  private func fitSizes() {
    dateLabel.sizeToFit()
    timeLabel.sizeToFit()
  }

  func prepareForReuse() {
    dateLabel.text = nil
    timeLabel.text = nil
  }

}
