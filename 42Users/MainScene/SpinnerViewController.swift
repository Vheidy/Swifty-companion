//
//  SpinnerViewController.swift
//  42Users
//
//  Created by Полина Салюкова on 27.06.2021.
//

import UIKit

class SpinnerViewController: UIViewController {

    // MARK: Lifecycle

    private var spinner: UIActivityIndicatorView

    init() {
        spinner = UIActivityIndicatorView()
        super.init(nibName: nil, bundle: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.backgroundColor = UIColor.gray.cgColor
        view.alpha = 0.5
        setSpinner()
        spinner.startAnimating()
        spinner.color = .black
    }

    /// Set constraints
    func setSpinner() {
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
