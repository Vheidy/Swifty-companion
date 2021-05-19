//
//  New.swift
//  42Users
//
//  Created by Полина Салюкова on 18.05.2021.
//

import UIKit

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()x
        guard let text = searchBar.searchTextField.text, !text.isEmpty else { return }
        print(text)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()
        guard let text = searchBar.searchTextField.text, !text.isEmpty else { return }
        print(text)
    }
}
