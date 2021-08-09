//
//  ProjectViewCell.swift
//  42Users
//
//  Created by Полина Салюкова on 02.08.2021.
//

import UIKit

class ProjectViewCell: UITableViewCell {
    private enum Constants {
        static let widthImage: CGFloat = 25
        static let lightGreen: UIColor = #colorLiteral(red: 0.3598939776, green: 0.7207101583, blue: 0.3601943851, alpha: 1)
        static let lightRed: UIColor = #colorLiteral(red: 0.8459354639, green: 0.3884519935, blue: 0.4349290133, alpha: 1)
    }

    private let nameLabel: UILabel
    private let icon: UIImageView
    private let markLabel: UILabel
    private var currentColor: UIColor = .white

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        nameLabel = UILabel()
        markLabel = UILabel()
        icon = UIImageView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setNameLabel()
        setIcon()
        setMarkLabel()
        configureBackgroundView()
    }

    func configure(_ name: String, _ value: Int?, _ iconType: IconType) {
        configureNameLabel(with: name)
        configureIcon(with: iconType)
        configureMarkLabel(with: value)
    }
    
    private func setNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 60),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func setIcon() {
        contentView.addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            icon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            icon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            icon.widthAnchor.constraint(equalToConstant: Constants.widthImage),
            icon.heightAnchor.constraint(equalToConstant: Constants.widthImage)
        ])
    }

    private func setMarkLabel() {
        contentView.addSubview(markLabel)
        markLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            markLabel.trailingAnchor.constraint(equalTo: icon.leadingAnchor, constant: -10),
            markLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            markLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
    }

    private func configureBackgroundView() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    private func configureMarkLabel(with value: Int?) {
        guard let mark = value else { return }
        markLabel.text = String(mark)
        markLabel.font = UIFont(name: "Helvetica", size: 20)
        markLabel.textColor = currentColor
        markLabel.numberOfLines = 0
    }

    private func configureIcon(with iconType: IconType) {
        let systemIcon = UIImage(systemName: iconType.rawValue)?.withRenderingMode(.alwaysTemplate)
        icon.image = systemIcon
        switch iconType {
        case .checkmark:
            currentColor = Constants.lightGreen
        case .clock:
            currentColor = .lightGray
        default:
            currentColor = Constants.lightRed
        }
        icon.tintColor = currentColor
    }
    
    private func configureNameLabel(with name: String) {
        nameLabel.text = name
        nameLabel.font = UIFont(name: "Helvetica", size: 20)
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 0
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
