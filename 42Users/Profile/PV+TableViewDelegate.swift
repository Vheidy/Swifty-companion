//
//  PV+TableViewDelegate.swift
//  42Users
//
//  Created by Полина Салюкова on 27.06.2021.
//

import UIKit

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = manager.fetchItem(for: section)
        switch section {
        case .details(let items):
            return items.count
        case .skills(let items):
            return items.count
        case .project(let items):
            return items.count
        default:
            return 1
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return manager.countOfCells
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = manager.fetchItem(for: indexPath.section) else { return UITableViewCell() }
        switch item {
        case .image(let url):
            guard let imageCell = tableView.dequeueReusableCell(withIdentifier: "ImageViewCell") as? ImageViewCell else { return UITableViewCell() }
            imageCell.configureImage(with: url)
            return imageCell
        case .name(let userName):
            return createNameCell(with: userName)
        case .details(let details):
            let detail = details[indexPath.row]
            guard let detailCell = tableView.dequeueReusableCell(withIdentifier: "DetailViewCell") as? DetailViewCell else { return UITableViewCell() }
            detailCell.configure(detail.name, with: detail.value)
            return detailCell
        case .curs:
            guard let cursCell = tableView.dequeueReusableCell(withIdentifier: "SelectCursCell") as? SelectCursCell else { return UITableViewCell() }
            cursCell.configure(with: pickerView)
            return cursCell
        case .level(let value):
            guard let levelCell = tableView.dequeueReusableCell(withIdentifier: "LevelViewCell") as? LevelViewCell else { return UITableViewCell() }
            levelCell.configure(with: value)
            return levelCell
        case .skills(let items):
            let skill = items[indexPath.row]
            guard let skillCell = tableView.dequeueReusableCell(withIdentifier: "SkillViewCell") as? SkillViewCell else { return UITableViewCell() }
            skillCell.configure(skill.name, with: skill.level)
            return skillCell
        case .project(let projects):
            let project = projects[indexPath.row]
            guard let projectCell = tableView.dequeueReusableCell(withIdentifier: "ProjectViewCell") as? ProjectViewCell else { return UITableViewCell() }
            projectCell.configure(project.name, project.finalMark, project.icon)
            return projectCell
        }
    }
    
    private func createNameCell(with name: String) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = name
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "Helvetica Bold", size: 30)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let section = manager.fetchItem(for: section)
        switch section {
        case .skills(_), .project(_):
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = manager.fetchItem(for: section)
        switch section {
        case .skills(_):
            return CustomHeader(with: "Skills")
        case .project(_):
            return CustomHeader(with: "Projects")
        default:
            return nil
        }
    }
    
}
