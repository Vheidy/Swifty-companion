//
//  ProfileManager.swift
//  42Users
//
//  Created by Полина Салюкова on 27.06.2021.
//

import Foundation

class ProfileManager {
    var indexForCursItem: Int? {
        displayItem.items.firstIndex { item in
            if case .curs = item {
                return true
            }
            return false
        }
    }

    var countOfCells: Int {
        return displayItem.items.count
    }

    private let userData: UserData
    private var displayItem: DisplayItem!
    private let cursusIDs: [CursType: Int] = [.oldGraph: 1, .piscine: 4, .newGraph: 21]
    private var filteredProjects: [CursType: [ItemType.Project]] = [:]

    init(with userData: UserData) {
        self.userData = userData
        
        createDisplayItem()
    }

    func fetchItem(for index: Int) -> ItemType? {
        guard displayItem.items.indices.contains(index) else { return nil }
        return displayItem.items[index]
    }

    func updateProjects(with curs: CursType) {
        guard let currentProjects = filteredProjects[curs], !currentProjects.isEmpty else { return }
        if CursManager.currentCurs != .undefined {
            displayItem.items.removeLast(3)
        }
        CursManager.currentCurs = curs
        addLevel()
        addSkills()
        addProjects(currentProjects)
    }
    
    private func createDisplayItem() {
        displayItem = DisplayItem(
            items: [
                .image(url: userData.image_url),
                .name(userData.usual_full_name),
                .details([ItemType.Detail(name: "Wallet", value: userData.wallet),
                          ItemType.Detail(name: "Evaluation points", value: userData.correction_point),
                          ItemType.Detail(name: userData.email, value: nil)]),
                .curs
            ]
        )
        addLevel()
        addSkills()
        filteredProjects = filterProject(userData.projects_users)
        guard let currentProjects = filteredProjects[CursManager.currentCurs] else { return }
        addProjects(currentProjects)
    }

    private func filterProject(_ projetsInfo: [ProjectInfo]) -> [CursType: [ItemType.Project]] {
        var result: [CursType: [ItemType.Project]] = [.newGraph : [], .piscine: [], .oldGraph: []]
        for key in result.keys {
            if let cursusID = cursusIDs[key] {
                let info = projetsInfo.filter { projectInfo in
                    projectInfo.cursusIDs.contains(cursusID)
                }
                result[key] = transformInfoInProject(info)
            }
        }
        return result
    }
    
    private func transformInfoInProject(_ projectInfo: [ProjectInfo]) -> [ItemType.Project] {
        var result: [ItemType.Project] = []
        
        for info in projectInfo {
            let icon = defineIconType(validated: info.validated, finalMark: info.final_mark)
            let project = ItemType.Project(name: info.project.name, finalMark: info.final_mark, icon: icon)
            result.append(project)
        }
        
        return result
    }
    
    private func addLevel() {
        guard let cursData = CursManager.currentCurs.fetchValues() else { return }
        displayItem.items.append(.level(userData.cursus_users[cursData.index].level))
    }
    
    private func addSkills() {
        guard let cursData = CursManager.currentCurs.fetchValues() else { return }
        var resultSkills: [ItemType.Skill] = []
        for skill in userData.cursus_users[cursData.index].skills {
            resultSkills.append(ItemType.Skill(name: skill.name, level: skill.level))
        }
        displayItem.items.append(.skills(resultSkills))
    }
    
    private func addProjects(_ projects: [ItemType.Project]) {
        displayItem.items.append(.project(projects))
    }
    
    private func defineIconType(validated: Bool?, finalMark: Int?) -> IconType {
        if validated == nil {
            return .clock
        } else if let validated = validated, validated == true, let _ = finalMark {
            return .checkmark
        } else {
            return .xmark
        }
    }
}
