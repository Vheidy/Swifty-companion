//
//  SceneDelegate.swift
//  42Users
//
//  Created by Полина Салюкова on 15.05.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MaincSceneViewController()
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
    }
}

