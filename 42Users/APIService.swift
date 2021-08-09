//
//  APIService.swift
//  42Users
//
//  Created by Полина Салюкова on 18.06.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

enum APIError: Error {
    case serverError
    case parseError
    case unknownName
    case undefined
}

class ApiService {
    var token: String? {
        willSet {
            guard newValue != nil else {
                UserDefaults.standard.removeObject(forKey: Constants.tokenKey)
                return
            }
            UserDefaults.standard.set(newValue, forKey: Constants.tokenKey)
        }
    }
    
    var bearer: String? {
        get {
            guard let token = token else { return nil }
            return "\(Constants.bearer) \(token)"
        }
    }
    
    var errorAction: ((APIError) -> ())?
    
    private enum Constants {
        static let tokenKey = "token"
        static let bearer = "Bearer"
        static let basedURL = "https://api.intra.42.fr"
    }
    
    private enum PathCreater {
        
        static func fetchTokenURL() -> String {
            return "\(Constants.basedURL)/oauth/token"
        }
        
        static func fetchTokenInfoURL() -> String {
            return PathCreater.fetchTokenURL() + "/info"
        }
        
        static func fetchUserInfoURL(with name: String) -> String {
            return "\(Constants.basedURL)/v2/users/\(name)"
        }
    }
    
    private let configuration = [
        "grant_type": "client_credentials",
        "client_id": "db53185146553c2508ce8b47678ac7621a216d047308403c62e8eeed7fa53fe4",
        "client_secret": "bd39a056661885f565dc47c288232f95223d90d633805fcbbd5c3e1ba8ac1f38"
    ]
    
    init() {
        startCheckToken()
        checkToken()
    }
    
    func startCheckToken() {
        guard let token = UserDefaults.standard.object(forKey: Constants.tokenKey) as? String else {
            fetchToken()
            return
        }
        self.token = token
    }
    
    func fetchToken() {
        DispatchQueue.global().async {
            AF.request(
                PathCreater.fetchTokenURL(),
                method: .post,
                parameters: self.configuration
            ).validate().responseJSON { [weak self] response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    self?.token = json["access_token"].stringValue
                case .failure(_):
                    self?.errorAction?(.undefined)
                }
            }
        }
    }
    
    func checkToken() {
        DispatchQueue.global().async { [weak self] in
            guard let bearer = self?.bearer , let url = URL(string: PathCreater.fetchTokenInfoURL()) else {
                self?.fetchToken()
                return
            }
            
            var request = URLRequest(url: url)
            request.method = .get
            request.setValue(bearer, forHTTPHeaderField: "Authorization")
            
            AF.request(request as URLRequestConvertible).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("The token works fine. Expires in seconds: \(json["expires_in_seconds"])")
                case .failure(_):
                    print("Please fetch a new token")
                    self?.fetchToken()
                }
            }
        }
    }
    
    func checkUser(_ userName: String, completion: @escaping (Result<Data, APIError>) -> ()) {
        checkToken()
        DispatchQueue.global().async { [weak self] in
        guard let bearer = self?.bearer, let url = URL(string: PathCreater.fetchUserInfoURL(with: userName)) else {
            self?.fetchToken()
            return
        }
        var request = URLRequest(url: url)
        request.method = .get
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        
        AF.request(request as URLRequestConvertible).validate().response { response in
            switch response.result {
            case .success(let value):
                if let data = value {
                    completion(.success(data))
                } else {
                    completion(.failure(.serverError))
                }
            case .failure(_):
                completion(.failure(.serverError))
            }
        }
        }
    }
}
