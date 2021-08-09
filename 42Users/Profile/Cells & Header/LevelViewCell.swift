//
//  LevelViewCell.swift
//  42Users
//
//  Created by Полина Салюкова on 08.07.2021.
//

import UIKit

class LevelViewCell: UITableViewCell {
    
    private enum Constants {
        static let heightLevelProgress: CGFloat = 30
    }
    
    private let progressView: UIProgressView
    private let levelLabel: UILabel

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        progressView = UIProgressView()
        levelLabel = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setProgressView()
        setLevelLabel()
        configureBackground()
    }

    func configure(with value: Float) {
        configureProgressView(with: value)
        configureLevelLabel(with: value)
    }

    private func configureLevelLabel(with value: Float) {
        levelLabel.text = String(value)
    }
    
    private func configureProgressView(with value: Float) {
        progressView.setProgress(value / 21 , animated: true)
        progressView.progressTintColor = .white
        progressView.trackTintColor = .white.withAlphaComponent(0.5)
    }
    
    private func configureBackground() {
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    private func setLevelLabel() {
        progressView.addSubview(levelLabel)
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            levelLabel.centerXAnchor.constraint(equalTo: progressView.centerXAnchor),
            levelLabel.centerYAnchor.constraint(equalTo: progressView.centerYAnchor)
        ])
    }

    private func setProgressView() {
        contentView.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            progressView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            progressView.heightAnchor.constraint(equalToConstant: Constants.heightLevelProgress)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
