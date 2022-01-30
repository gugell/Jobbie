//
//  ShiftCollectionViewCell.swift
//  Jobbie
//
//  Created by Ilia Gutu on 30.01.2022.
//

import UIKit

final class ShiftCollectionViewCell: UICollectionViewCell, Reusable, BindableType {

    var viewModel: ShiftCellViewModel!

    private lazy var weekDayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = Colors.red()
        label.textAlignment = .center

        return label
    }()

    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = Colors.black()
        label.textAlignment = .center

        return label
    }()

    private lazy var hoursLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = Colors.gray()
        label.textAlignment = .center

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    private func setupUI() {
        contentView.layer.cornerRadius = 5
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = Colors.red().cgColor

        weekDayLabel.add(to: contentView)
            .top(to: \.topAnchor, of: self, constant: 20)
            .leading(to: \.leadingAnchor, constant: 10)
            .centerX(to: \.centerXAnchor)

        dayLabel.add(to: contentView)
            .top(to: \.bottomAnchor, of: weekDayLabel, constant: 10)
            .leading(to: \.leadingAnchor, constant: 10)
            .centerX(to: \.centerXAnchor)

        hoursLabel.add(to: contentView)
            .top(to: \.bottomAnchor, of: dayLabel, constant: 10)
            .leading(to: \.leadingAnchor, constant: 10)
            .centerX(to: \.centerXAnchor)
            .bottom(to: \.bottomAnchor, constant: 20)
    }

    func bindViewModel() {
        weekDayLabel.text = viewModel.weekday
        dayLabel.text = viewModel.day
        hoursLabel.text = viewModel.hours
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

struct ShiftCellViewModel: Hashable {
    let weekday: String
    let hours: String
    let day: String
}

extension ShiftCellViewModel {
    init(shift: Shift) {
        weekday = shift.beginDate.day
        day = shift.beginDate.toString(format: "dd.MM")
        hours = "\(shift.beginDate.timeIn24HourFormat()) - \(shift.endDate.timeIn24HourFormat())"
    }
}
