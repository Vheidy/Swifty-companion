//
//  MainSceneManager.swift
//  42Users
//
//  Created by Полина Салюкова on 18.06.2021.
//

import Foundation

typealias VoidCallback = () -> ()

class MainSceneManager {
    var apiService: ApiService
    weak var viewConrtoller: MaincSceneViewController? {
        didSet {
            if let vc = viewConrtoller {
                apiService.errorAction = ErrorHandler.createActionShowAlert(on: vc)
            }
        }
    }

    init() {
        apiService = ApiService()
    }
    
    func findUser(_ userName: String) {
        guard !userName.contains(" ") else {
            if let vc = viewConrtoller {
                ErrorHandler.showAlert(for: .unknownName, on: vc)
            }
            return
        }
        viewConrtoller?.isLoading = true
        apiService.checkUser(userName.lowercased()) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    var result = try JSONDecoder().decode(UserData.self, from: data)
                    result.projects_users = result.projects_users.filter{$0.project.parent_id == nil}
                    self?.viewConrtoller?.presentResultViewController(with: result)
                } catch {
                    if let vc = self?.viewConrtoller {
                        ErrorHandler.showAlert(for: .undefined, on: vc)
                    }
                }
                self?.viewConrtoller?.isLoading = false
            case .failure(let error):
                self?.viewConrtoller?.isLoading = false
                if let vc = self?.viewConrtoller {
                    ErrorHandler.showAlert(for: error, on: vc)
                }
            }
            
        }
    }
    
}
