//
//  MainSceneViewController.swift
//  42Users
//
//  Created by Полина Салюкова on 15.05.2021.
//

import UIKit

class MaincSceneViewController: UIViewController, UITextFieldDelegate {
    var manager: MainSceneManager

    var isLoading: Bool {
        willSet {
            if newValue == true {
                addSpinner()
            } else {
                removeSpinner()
            }
        }
    }

    private enum ImageSize {
        static let height: CGFloat = 200
        static let width: CGFloat = ImageSize.height
        
    }

    private var searchBar: UISearchBar
    private var backgroundView: UIImageView
    private var logoView: UIImageView
    private var spinnerVC: UIViewController?

    // MARK: Lifecycle

    init() {
        searchBar = UISearchBar()
        backgroundView = UIImageView()
        logoView = UIImageView()
        manager = MainSceneManager()
        isLoading = false
        super.init(nibName: nil, bundle: nil)
        manager.viewConrtoller = self

        configureBackgroundView()
        configureSearchBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundImage()
        setSearchBar()
        setLogoView()
    }
    
    func presentResultViewController(with userData: UserData) {
        isLoading = false
        let profileVC = ProfileViewController(with: ProfileManager(with: userData))
        let nv = UINavigationController(rootViewController: profileVC)
        present(nv, animated: true, completion: nil)
    }
    
    // MARK: Add/remove spinnerView

    func addSpinner() {
        let spinnerVC = SpinnerViewController()
        self.addChild(spinnerVC)
        view.addSubview(spinnerVC.view)
        
        NSLayoutConstraint.activate([
            spinnerVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            spinnerVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            spinnerVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            spinnerVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        self.spinnerVC = spinnerVC
    }
    
    func removeSpinner() {
        guard let spinner = spinnerVC else { return }
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
    
    // MARK: Set constraints
    func setLogoView() {
        backgroundView.addSubview(logoView)
        logoView.translatesAutoresizingMaskIntoConstraints = true
        
        logoView.image = UIImage(named: "42Logo")
        logoView.frame = CGRect(x: view.bounds.midX - ImageSize.width / 1.7, y: view.bounds.midY/4, width: ImageSize.width, height: ImageSize.height)
    }
    
    func setSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Enter nickname"
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.9058247209, green: 0.9059216976, blue: 0.9136740565, alpha: 1)
        searchBar.searchBarStyle = .default
    }
    
    private func setBackgroundImage() {
        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    // MARK: Configure view

    func configureBackgroundView() {
        backgroundView.frame = view.bounds
        backgroundView.image = UIImage(named: "backgroundImage")
        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewEndEditing)))
        backgroundView.contentMode = .scaleAspectFill
        backgroundView.clipsToBounds = true
    }
    
    private func configureSearchBar() {
        backgroundView.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])

    }
    
    // MARK: Support methods
    
    @objc func viewEndEditing() {
        self.view.endEditing(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
