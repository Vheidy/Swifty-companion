//
//  SearchViewController.swift
//  42Users
//
//  Created by Полина Салюкова on 15.05.2021.
//

import UIKit

enum ImageSize {
    static let height: CGFloat = 200
    static let width: CGFloat = ImageSize.height
    
}

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    var searchBar: UISearchBar
    var backgroundView: UIImageView
    var logoView: UIImageView
    
    init() {
        searchBar = UISearchBar()
        backgroundView = UIImageView()
        logoView = UIImageView()
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundImage()
                configureSearchBar()
        setLogoView()
    }
    
    func setLogoView() {
        backgroundView.addSubview(logoView)
        logoView.translatesAutoresizingMaskIntoConstraints = true
        logoView.image = UIImage(named: "42Logo")
        logoView.frame = CGRect(x: backgroundView.bounds.midX - ImageSize.width / 1.7, y: backgroundView.bounds.midY/4, width: ImageSize.width, height: ImageSize.height)
    }
    
    private func setBackgroundImage() {
        backgroundView.frame = view.bounds
        backgroundView.image = UIImage(named: "backgroundImage")
        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewEndEditing)))
        view.addSubview(backgroundView)
                backgroundView.contentMode = .scaleAspectFill
        backgroundView.clipsToBounds = true
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    @objc func viewEndEditing() {
        self.view.endEditing(true)
    }
    
    private func configureSearchBar() {
        backgroundView.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        searchBar.placeholder = "Enter nickname"
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.9058247209, green: 0.9059216976, blue: 0.9136740565, alpha: 1)
        searchBar.searchBarStyle = .default

        NSLayoutConstraint.activate([
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
//            searchBar.heightAnchor.constraint(equalToConstant:  10)
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
