//
//  User.swift
//  Favorites
//
//  Created by Dmytro Horodyskyi on 21.03.2023.
//

import Foundation

struct User: Codable, Identifiable {
    var id = UUID()
    let login: String
    let avatar_url: String
}
