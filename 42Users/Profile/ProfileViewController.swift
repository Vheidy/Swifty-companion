//
//  ProfileViewController.swift
//  42Users
//
//  Created by Полина Салюкова on 18.06.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    var tableView: UITableView
    var pickerView: UIPickerView
    var manager: ProfileManager

    private var backgroundView: UIImageView

    init(with manager: ProfileManager) {
        backgroundView = UIImageView()
        pickerView = UIPickerView()
        self.manager = manager
        tableView = UITableView(frame: .null, style: .grouped)
        super.init(nibName: nil, bundle: nil)
        
        configureBackgroundView()
        configureTableView()
        configurePickerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundImage()
        setNavigationBar()
        setTableView()
    }

    func reloadProjects(with curs: CursType) {
        manager.updateProjects(with: curs)
        tableView.reloadData()
    }
    
    func setNavigationBar() {
        navigationItem.setLeftBarButton(UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeScreen)), animated: true)
        navigationItem.title = "Profile"
    }
    
    private func setTableView() {
        backgroundView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 72),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
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

    private func configurePickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
//        guard let cursData = CursManager.currentCurs.fetchValues() else { return }
//        pickerView.selectRow(cursData.index, inComponent: 0, animated: false)
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        
        tableView.register(ImageViewCell.self, forCellReuseIdentifier: "ImageViewCell")
        tableView.register(DetailViewCell.self, forCellReuseIdentifier: "DetailViewCell")
        tableView.register(SelectCursCell.self, forCellReuseIdentifier: "SelectCursCell")
        tableView.register(LevelViewCell.self, forCellReuseIdentifier: "LevelViewCell")
        tableView.register(SkillViewCell.self, forCellReuseIdentifier: "SkillViewCell")
        tableView.register(ProjectViewCell.self, forCellReuseIdentifier: "ProjectViewCell")
    }
    
    private func configureBackgroundView() {
        backgroundView.frame = view.bounds
        backgroundView.image = UIImage(named: "backgroundImage")
        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewEndEditing)))
        backgroundView.contentMode = .scaleAspectFill
        backgroundView.clipsToBounds = true
    }
    
    @objc func viewEndEditing() {
        self.view.endEditing(true)
    }
    
    @objc func closeScreen() {
        CursManager.currentCurs = .undefined
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
