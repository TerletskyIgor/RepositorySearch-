//
//  APIError.swift
//  RepositorySearch
//
//  Created by Igor Terletskyi on 02.09.2025.
//

import Foundation

enum APIError: LocalizedError {
    case urlError
    case networkError(Error)
    case decodingError(Error)
    case rateLimited(resetAt: Date?)
    case serverError(statusCode: Int)
    case emptyQuery
    
    var errorDescription: String? {
        switch self {
        case .urlError:
            return "Invalid URL"
        case .networkError(let e):
            return e.localizedDescription
        case .decodingError:
            return "Failed to decode response"
        case .rateLimited:
            return "Rate limit exceeded"
        case .serverError(let code):
            return "Server error: \(code)"
        case .emptyQuery:
            return "Query is empty"
        }
    }
}
