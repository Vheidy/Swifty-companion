//
//  CursManager.swift
//  42Users
//
//  Created by Полина Салюкова on 09.08.2021.
//

import Foundation

enum CursType: Hashable, CaseIterable {
    case oldGraph
    case piscine
    case newGraph
    case undefined

    func fetchValues() -> (name: String, index: Int)? {
        switch self {
        case .newGraph:
            return ("42cursus", 2)
        case .piscine:
            return ("Piscine C", 1)
        case .oldGraph:
            return ("42", 0)
        case .undefined:
            return nil
        }
    }

    static func fetchProjectForID(_ id: Int) -> CursType {
        switch id {
        case 2:
            return .newGraph
        case 1:
            return .piscine
        case 0:
            return .oldGraph
        default:
            return .undefined
        }
    }
}

struct CursManager {
    static var currentCurs: CursType = .undefined
}
