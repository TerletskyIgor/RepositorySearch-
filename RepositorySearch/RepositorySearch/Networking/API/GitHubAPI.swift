//
//  GitHubAPI.swift
//  RepositorySearch
//
//  Created by Igor Terletskyi on 02.09.2025.
//

import Foundation

actor GitHubAPI {
    static let shared = GitHubAPI()
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func searchRepositories(query: String) async throws -> [Repository] {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { throw APIError.emptyQuery }
        
        guard var components = URLComponents(string: "https://api.github.com/search/repositories") else {
            throw APIError.urlError
        }
        
        components.queryItems = [
            URLQueryItem(name: "q", value: trimmed),
            URLQueryItem(name: "per_page", value: "50")
        ]
        
        guard let url = components.url else { throw APIError.urlError }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        
        if let token = KeychainHelper.shared.read(service: "GitHub", account: "PersonalAccessToken") {
            request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
        }

        let (data, response) = try await session.data(for: request)
        // try Task.checkCancellation()
        
        if let http = response as? HTTPURLResponse {
            if http.statusCode == 403 {
                let reset = parseRateLimitReset(http)
                throw APIError.rateLimited(resetAt: reset)
            }
            if !(200...299).contains(http.statusCode) {
                throw APIError.serverError(statusCode: http.statusCode)
            }
        }
        
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(SearchResponse.self, from: data)
            return result.items
        } catch {
            throw APIError.decodingError(error)
        }
    }
    
    private func parseRateLimitReset(_ response: HTTPURLResponse) -> Date? {
        if let resetString = response.value(forHTTPHeaderField: "X-RateLimit-Reset"), let ts = TimeInterval(resetString) {
            return Date(timeIntervalSince1970: ts)
        }
        return nil
    }
}
