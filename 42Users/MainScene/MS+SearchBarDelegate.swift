//
//  MS+SearchBarDelegate.swift
//  42Users
//
//  Created by Полина Салюкова on 18.05.2021.
//

import UIKit

extension MaincSceneViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.searchTextField.text, !text.isEmpty else { return }
        manager.findUser(text)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.searchTextField.text, !text.isEmpty else { return }
        manager.findUser(text)
    }
}
