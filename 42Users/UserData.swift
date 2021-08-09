//
//  UserData.swift
//  42Users
//
//  Created by Полина Салюкова on 27.06.2021.
//

import Foundation

struct Skill: Codable {
    var name: String
    var level: Float
}

struct CursUser: Codable {
    var skills: [Skill]
    var level: Float
}

struct Project: Codable {
    var name: String
    var parent_id: Int?
}

struct ProjectInfo: Decodable {
    private enum CodingKeys: String, CodingKey {
        case project
        case final_mark = "final_mark"
        case validated = "validated?"
        case cursusIDs = "cursus_ids"
    }
    var project: Project
    var final_mark: Int?
    var validated: Bool?
    var cursusIDs: [Int]
}

struct UserData: Decodable {
    var image_url: String
    var correction_point: Int
    var usual_full_name: String
    var wallet: Int
    var email: String
    var cursus_users: [CursUser]
    var projects_users: [ProjectInfo]
}
