//
//  ProfileVC+PickerViewDelegate.swift
//  42Users
//
//  Created by Полина Салюкова on 06.08.2021.
//

import UIKit

//struct CurrentIDService {
//    static var id: Int = 1
//}

extension ProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        CursType.allCases.count - 1
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        reloadProjects(with: CursType.fetchProjectForID(row))
        guard let section = manager.indexForCursItem,
              let cell = tableView.cellForRow(at: IndexPath(row: 0, section: section) ) as? SelectCursCell,
              let cursData = CursManager.currentCurs.fetchValues()
        else { return }
        cell.reloadTextField(with: cursData.name)
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let project = CursType.fetchProjectForID(row)
        return project.fetchValues()?.name
    }

    
}
