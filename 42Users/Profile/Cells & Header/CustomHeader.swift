//
//  CustomHeader.swift
//  42Users
//
//  Created by Полина Салюкова on 12.07.2021.
//

import UIKit

class CustomHeader: UITableViewHeaderFooterView {
    private var title: UILabel
    
    init(with text: String) {
        title = UILabel()
        super.init(reuseIdentifier: nil)
        
        self.backgroundColor = .clear
        tintColor = .clear
        contentView.backgroundColor = .clear
        setTitleLabel()
        setConfigureTitleLabel(with: text)
    }
    
    private func setConfigureTitleLabel(with text: String) {
        title.text = text
        
        title.textColor = .white
        title.textAlignment = .center
        title.font = UIFont(name: "Helvetica Bold", size: 30)
    }
    
    private func setTitleLabel() {
        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor),
            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
