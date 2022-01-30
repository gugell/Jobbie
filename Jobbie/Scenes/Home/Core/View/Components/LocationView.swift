//
//  LocationView.swift
//  Zenjob iOS Challenge
//
//  Created by Milos Milakovic on 22.09.20.
//  Copyright © 2020 Zenjob. All rights reserved.
//

import UIKit

final class LocationView: UIView {

  let cityLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = UIColor(red: 0.314, green: 0.325, blue: 0.365, alpha: 1.0)
    label.font = UIFont.boldSystemFont(ofSize: 14)
    return label
  }()

  let districtLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = UIColor(red: 0.631, green: 0.651, blue: 0.690, alpha: 1.00)
    label.font = UIFont.boldSystemFont(ofSize: 14)
    label.textAlignment = .right
    return label
  }()

  let locationIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    self.layer.masksToBounds = true
    self.addSubview(cityLabel)
    self.addSubview(districtLabel)
    self.addSubview(locationIcon)

  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    NSLayoutConstraint.activate([
      locationIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
      locationIcon.centerYAnchor.constraint(equalTo: cityLabel.centerYAnchor),
      locationIcon.heightAnchor.constraint(equalToConstant: 20),
      locationIcon.widthAnchor.constraint(equalTo: locationIcon.heightAnchor),

      districtLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
      districtLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
      districtLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),

      cityLabel.leftAnchor.constraint(equalTo: locationIcon.rightAnchor, constant: 10),
      cityLabel.rightAnchor.constraint(equalTo: districtLabel.leftAnchor, constant: 10),
      cityLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
      cityLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
      ])
  }

  override func layoutSublayers(of layer: CALayer) {
    super.layoutSublayers(of: layer)
    fitSizes()
  }

  func populate(location: Location) {
    fitSizes()
    districtLabel.text = location.district ?? "District"
    cityLabel.text = location.city ?? "City"
      locationIcon.image = Assets.pin()
  }

  private func fitSizes() {
    districtLabel.sizeToFit()
    cityLabel.sizeToFit()
  }

  func prepareForReuse() {
    districtLabel.text = nil
    cityLabel.text = nil
  }

}
