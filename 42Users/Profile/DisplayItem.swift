//
//  DisplayItem.swift
//  42Users
//
//  Created by Полина Салюкова on 27.06.2021.
//

import Foundation

enum IconType: String {
    case xmark = "xmark"
    case checkmark = "checkmark"
    case clock = "clock"
}

enum ItemType {
    struct Detail {
        var name: String
        var value: Int?
    }
    
    struct Skill {
        var name: String
        var level: Float
    }
    
    struct Project {
        var name: String
        var finalMark: Int?
        var icon: IconType
    }

    case image(url: String)
    case details([Detail])
    case name(String)
    case level(Float)
    case curs
    case skills([Skill])
    case project([Project])
    
}

struct DisplayItem {
    var items: [ItemType]
}
