//
//  SearchResponse.swift
//  RepositorySearch
//
//  Created by Igor Terletskyi on 02.09.2025.
//

import Foundation

struct SearchResponse: Decodable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repository]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
