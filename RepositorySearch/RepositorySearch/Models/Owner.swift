//
//  Owner.swift
//  RepositorySearch
//
//  Created by Igor Terletskyi on 02.09.2025.
//

import Foundation

struct Owner: Decodable {
    let login: String
    let id: Int
    let avatarURL: URL?

    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
    }
}
