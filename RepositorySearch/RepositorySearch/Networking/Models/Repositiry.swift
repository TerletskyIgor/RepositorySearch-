//
//  Repositiry.swift
//  RepositorySearch
//
//  Created by Igor Terletskyi on 02.09.2025.
//

import Foundation

struct Repository: Identifiable, Decodable {
    let id: Int
    let name: String
    let fullName: String
    let description: String?
    let stargazersCount: Int
    let forksCount: Int
    let htmlURL: URL?
    let language: String?
    let owner: Owner

    enum CodingKeys: String, CodingKey {
        case id, name, description, language, owner
        case fullName = "full_name"
        case stargazersCount = "stargazers_count"
        case forksCount = "forks_count"
        case htmlURL = "html_url"
    }
}
