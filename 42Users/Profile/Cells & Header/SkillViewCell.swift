//
//  SkillViewCell.swift
//  42Users
//
//  Created by Полина Салюкова on 08.07.2021.
//

import UIKit

class SkillViewCell: UITableViewCell {

    private let nameLabel: UILabel
    private let progressView: UIProgressView
    private let progressLabel: UILabel

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)  {
        nameLabel = UILabel()
        progressView = UIProgressView()
        progressLabel = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setNameLabel()
        setProgressView()
        setProgressLabel()
        configureBackgroundView()
    }

    func configure(_ name: String, with value: Float) {
        configureNameLabel(with: name)
        configureProgressView(with: value)
        configureProgressLabel(with: value)
    }

    private func setNameLabel() {
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setProgressView() {
        contentView.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 20),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            progressView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            progressView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setProgressLabel() {
        progressView.addSubview(progressLabel)
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progressLabel.centerXAnchor.constraint(equalTo: progressView.centerXAnchor),
            progressLabel.centerYAnchor.constraint(equalTo: progressView.centerYAnchor)
        ])
    }
    
    private func configureBackgroundView() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    private func configureNameLabel(with name: String) {
        nameLabel.text = name
        nameLabel.font = UIFont(name: "Helvetica", size: 15)
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 0
    }
    
    private func configureProgressView(with value: Float) {
        progressView.setProgress(value / 21 , animated: true)
        progressView.progressTintColor = .white
        progressView.trackTintColor = .white.withAlphaComponent(0.5)
    }
    
    private func configureProgressLabel(with value: Float) {
        progressLabel.text = String(value)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
