//
//  SearchViewModel.swift
//  RepositorySearch
//
//  Created by Igor Terletskyi on 02.09.2025.
//

import SwiftUI

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var repositories: [Repository] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var searchTask: Task<Void, Never>? = nil
    
    func onQueryChanged() {
        searchTask?.cancel()
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            repositories = []
            return
        }
        searchTask = Task { await performSearch(query: query) }
    }
    
    private func performSearch(query: String) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        do {
            let items = try await GitHubAPI.shared.searchRepositories(query: query)
            if Task.isCancelled { return }
            self.repositories = items
        } catch {
            if Task.isCancelled { return }
            if let apiError = error as? APIError {
                self.errorMessage = apiError.errorDescription
            } else {
                self.errorMessage = error.localizedDescription
            }
            self.repositories = []
        }
    }
}
