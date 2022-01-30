//
//  GeneralView.swift
//  Zenjob iOS Challenge
//
//  Created by Milos Milakovic on 22.09.20.
//  Copyright © 2020 Zenjob. All rights reserved.
//

import UIKit

final class GeneralView: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    let totalEarnLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    let hourlyEarnLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.layer.opacity = 0.8
        return label
    }()

    let generalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.layer.masksToBounds = true
        self.addSubview(titleLabel)
        self.addSubview(totalEarnLabel)
        self.addSubview(hourlyEarnLabel)
        self.addSubview(generalLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            totalEarnLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            totalEarnLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            totalEarnLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),

            hourlyEarnLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            hourlyEarnLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            hourlyEarnLabel.topAnchor.constraint(equalTo: totalEarnLabel.bottomAnchor, constant: 5),

            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),

            generalLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15),
            generalLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15),
            generalLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10)
        ])
    }

    /// Tells the delegate a layer's bounds have changed.
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        fitSizes()
        applyGradient(startColor: UIColor(red: 0.980,
                                               green: 0.271,
                                               blue: 0.451,
                                               alpha: 1.0).cgColor,
                           endColor: UIColor(red: 0.290, green: 0.149, blue: 0.592, alpha: 1.0).cgColor)
    }

    /// Populates the view's properties with an offer
    func populate(title: String, totalEarn: String, hourlyEarn: String) {
        fitSizes()
        titleLabel.text = title
        totalEarnLabel.text = totalEarn.toCurrency
        hourlyEarnLabel.text =         L10n.Offer.earnType(hourlyEarn.toCurrency)
    }

    func prepareForReuse() {
        titleLabel.text = nil
        totalEarnLabel.text = nil
        hourlyEarnLabel.text = nil
    }

    private func fitSizes() {
        totalEarnLabel.sizeToFit()
        hourlyEarnLabel.sizeToFit()
        titleLabel.sizeToFit()
        generalLabel.sizeToFit()
    }

}

extension UIView {
    func applyGradient(startColor: CGColor, endColor: CGColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.colors = [startColor, endColor]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension String {

    var toCurrency: String {
        return self.replacingOccurrences(of: " EUR", with: "€").replacingOccurrences(of: ".00", with: "")
    }

}
