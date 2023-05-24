//
//  Models.swift
//  ModelsOS
//
//  Created by DA MAC M1 124 on 2023/05/24.
//

import Foundation

// MARK: - TodoElement
struct Todo: Codable {
    let userID, id: Int
    let title: String
    let completed: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, completed
    }
}



