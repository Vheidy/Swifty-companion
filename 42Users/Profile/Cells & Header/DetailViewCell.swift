//
//  DetailViewCell.swift
//  42Users
//
//  Created by Полина Салюкова on 30.06.2021.
//

import UIKit

class DetailViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setBackground()
    }

    func configure(_ name: String, with value: Int?) {
        var currentContentConfiguration = defaultContentConfiguration()
        let font = UIFont(name: "Avenir", size: 20)
        let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
        currentContentConfiguration.attributedText = NSAttributedString(string: name, attributes: attributes as [NSAttributedString.Key : Any])
        if let value = value {
            let font = UIFont(name: "Avenir", size: 20)
            let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
            currentContentConfiguration.secondaryAttributedText = NSAttributedString(string: String(value), attributes: attributes as [NSAttributedString.Key : Any])
        }
        currentContentConfiguration.prefersSideBySideTextAndSecondaryText = true
        contentConfiguration = currentContentConfiguration
    }

    private func setBackground() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
