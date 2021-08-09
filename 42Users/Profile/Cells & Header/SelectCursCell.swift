//
//  SelectCursCell.swift
//  42Users
//
//  Created by Полина Салюкова on 04.08.2021.
//

import UIKit

class SelectCursCell: UITableViewCell, UITextFieldDelegate {
    private var textField: UITextField
    private var icon: UIImageView
    
    private enum Constants {
        static let iconWidth: CGFloat = 25
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        textField = UITextField()
        icon = UIImageView()
    
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setBackground()
        setTextFiled()
        setIcon()
        configureTextField()
        configureIcon()
    }

    func configure(with inputView: UIView) {
        textField.inputView = inputView
    }

    func reloadTextField(with text: String) {
        textField.text = text
    }

    private func setTextFiled() {
        contentView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }

    private func setIcon() {
        textField.addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: textField.topAnchor, constant: 10),
            icon.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: -10),
            icon.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -20),
            icon.widthAnchor.constraint(equalToConstant: Constants.iconWidth),
            icon.heightAnchor.constraint(equalToConstant: Constants.iconWidth)
        ])
    }
    
    private func setBackground() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    private func configureIcon() {
        let iconImage = UIImage(systemName: "arrowtriangle.down.fill")?.withRenderingMode(.alwaysTemplate)
        icon.image = iconImage
        icon.tintColor = .white
    }

    private func configureTextField() {
        textField.delegate = self
        textField.text = "Choose current curs"
        textField.textAlignment = .center
        textField.textColor = .white
        textField.tintColor = .clear
        textField.font = UIFont(name: "Avenir", size: 20)
        textField.backgroundColor = .black.withAlphaComponent(0.5)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
