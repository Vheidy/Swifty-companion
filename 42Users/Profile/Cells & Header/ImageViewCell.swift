//
//  ImageViewCell.swift
//  42Users
//
//  Created by Полина Салюкова on 30.06.2021.
//

import UIKit

struct ImageFetcher {
    static func fetchImage(from url: URL) -> UIImage? {
        do {
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        } catch {
            print("Error: Wrong URL")
            return nil
        }
    }
}

class ImageViewCell: UITableViewCell {
    private enum Constants {
        static let heightImage: CGFloat = 200
    }

    private var profileImageView: UIImageView

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        profileImageView = UIImageView()

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setImage()
        configureContentView()
    }

    
    func configureImage(with url: String) {
        let mockImage = UIImage(named: "ProfileView")
        guard let url = URL(string: url) else {
            return updateImage(mockImage)
        }
        DispatchQueue.global().async { [weak self] in
            let image = ImageFetcher.fetchImage(from: url)
            self?.updateImage(image)
        }
        updateImage(mockImage)
    }

    private func updateImage(_ image: UIImage?) {
        DispatchQueue.main.async { [weak self] in
            self?.profileImageView.image = image

            self?.profileImageView.layer.cornerRadius = Constants.heightImage / 2
            self?.profileImageView.layer.masksToBounds = true
        }
    }

    private func configureContentView() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        selectionStyle = .none
    }

    private func setImage() {
        contentView.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            profileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            profileImageView.widthAnchor.constraint(equalToConstant: Constants.heightImage),
            profileImageView.heightAnchor.constraint(equalToConstant: Constants.heightImage)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
